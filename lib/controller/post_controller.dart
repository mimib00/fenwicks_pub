import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  Rx<XFile?>? image;

  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("posts");
  final storageRef = FirebaseStorage.instance.ref();

  RxString status = "".obs;

  void selectImage() async {
    image = Rx<XFile?>(await _picker.pickImage(source: ImageSource.gallery));
    update();
  }

  void removeImage() {
    image = null;
    update();
  }

  void updateStatus(String state) {
    status.value = state;
    update();
  }

  /// Submit the post to firestore.
  ///
  /// First it upload the image if exists to firebase storage and the get URL and post the data with caption.
  void post(String caption) async {
    final AuthController authController = Get.find();
    final user = authController.user.value!;
    final path = "posts/${user.id!}/${DateTime.now().microsecondsSinceEpoch}";
    try {
      if (image == null && caption.isEmpty) throw "You must at least have an image or caption";
      // check if a photo is selected
      if (image != null) {
        updateStatus("Uploading Photo");
        Get.dialog(StatusCard(title: status.value), barrierDismissible: false);
        TaskSnapshot snapshot = await storageRef.child(path).putFile(File(image!.value!.path));
        if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) throw "There was an error durring upload";
        // if image uploaded successfully
        if (snapshot.state == TaskState.success) {
          updateStatus("Finishing up");
          var imageUrl = await snapshot.ref.getDownloadURL();
          Map<String, dynamic> data = {
            "caption": caption,
            "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
            "photo": imageUrl,
            "likes": [],
            "comments": [],
            "created_at": FieldValue.serverTimestamp(),
          };

          final post = await _ref.add(data);
          await authController.updateUserData({
            "posts": FieldValue.arrayUnion([
              _ref.doc(post.id)
            ])
          });
          Get.back(closeOverlays: true);
          Get.showSnackbar(messageCard("Post submited successfully"));
        }
      } else {
        updateStatus("Posting");
        Map<String, dynamic> data = {
          "caption": caption,
          "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
          "photo": "",
          "likes": [],
          "comments": [],
          "created_at": FieldValue.serverTimestamp(),
        };
        final post = await _ref.add(data);
        await authController.updateUserData({
          "posts": FieldValue.arrayUnion([
            _ref.doc(post.id)
          ])
        });
        Get.back(closeOverlays: true);
        Get.showSnackbar(messageCard("Post submited successfully"));
      }
      Get.back();
    } catch (e) {
      Get.showSnackbar(errorCard(e.toString()));
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getPosts() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? snap;
    try {
      snap = _ref.orderBy("created_at", descending: true).snapshots();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return snap;
  }

  void likePost(String id, String uid) async {
    try {
      await _ref.doc(id).set({
        "likes": FieldValue.arrayUnion([
          FirebaseFirestore.instance.collection("users").doc(uid)
        ])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  void unLikePost(String id, String uid) async {
    try {
      await _ref.doc(id).set({
        "likes": FieldValue.arrayRemove([
          FirebaseFirestore.instance.collection("users").doc(uid)
        ])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  void likeComment(String id, Map<String, dynamic> comment, String uid) async {
    try {
      Map<String, dynamic> temp = comment.map((key, value) => MapEntry(key, value));
      await _ref.doc(id).set({
        "comments": FieldValue.arrayRemove([
          comment
        ])
      }, SetOptions(merge: true));
      List<DocumentReference> likes = temp['likes'].cast<DocumentReference>();
      likes.add(FirebaseFirestore.instance.collection("users").doc(uid));
      temp["likes"] = likes;

      await _ref.doc(id).set({
        "comments": FieldValue.arrayUnion([
          temp
        ])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    update();
  }

  void unLikeComment(String id, Map<String, dynamic> comment, String uid) async {
    try {
      Map<String, dynamic> temp = comment.map((key, value) => MapEntry(key, value));
      await _ref.doc(id).set({
        "comments": FieldValue.arrayRemove([
          comment
        ])
      }, SetOptions(merge: true));
      List<DocumentReference> likes = temp['likes'].cast<DocumentReference>();
      likes.removeWhere((element) => element == FirebaseFirestore.instance.collection("users").doc(uid));
      temp["likes"] = likes;
      await _ref.doc(id).set({
        "comments": FieldValue.arrayUnion([
          temp
        ])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    update();
  }

  Future<void> comment(String id, Map<String, dynamic> comment) async {
    log(comment.toString());
    try {
      _ref.doc(id).set({
        "comments": FieldValue.arrayUnion([
          comment
        ])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
