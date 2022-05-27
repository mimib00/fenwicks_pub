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
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
