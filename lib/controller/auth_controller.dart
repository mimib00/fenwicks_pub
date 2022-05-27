import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../routes/routes.dart';

class AuthController extends GetxController {
  final _ref = FirebaseFirestore.instance.collection("users");
  final storageRef = FirebaseStorage.instance.ref();

  Rx<Users?> user = Rx<Users?>(null);

  /// login the user.
  void login(String email, String password) async {
    Get.dialog(const LoadingCard(), barrierDismissible: false);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  /// create a user in firebase authentication.
  void register(Users user, String password) async {
    Get.dialog(const LoadingCard(), barrierDismissible: false);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
    saveUserData(user);
  }

  /// Svae user data to a firestore collection call users
  void saveUserData(Users user) async {
    User userCredential = FirebaseAuth.instance.currentUser!;
    try {
      _ref.doc(userCredential.uid).set(user.toMap());
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    userCredential.sendEmailVerification();
    Get.showSnackbar(messageCard("Check email and verify email"));
  }

  /// Update user data in user's firestore collection call users
  Future<void> updateUserData(Map<String, dynamic> data) async {
    try {
      await _ref.doc(user.value!.id!).set(data, SetOptions(merge: true));
      await getUserData(user.value!.id!);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
    Get.back();
  }

  /// Update user email.
  void updateEmail(String email, String password) async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    try {
      AuthCredential authCredential = EmailAuthProvider.credential(email: currentUser.email!, password: password);
      UserCredential credential = await currentUser.reauthenticateWithCredential(authCredential);

      await credential.user!.updateEmail(email);
      credential.user!.sendEmailVerification();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
    logout();
    Get.back();
  }

  void addAddress(Map<String, dynamic> address) async {
    final addr = user.value!.address;
    try {
      addr.add(address);
      await _ref.doc(user.value!.id!).update({
        "address": addr,
      });
      await getUserData(user.value!.id!);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
    Get.back();
  }

  void removeAddress(Map<String, dynamic> address) async {
    try {
      await _ref.doc(user.value!.id!).update({
        "address": FieldValue.arrayRemove([
          address
        ]),
      });
      await getUserData(user.value!.id!);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  /// fetch user data from firestore and cast it to a [Users] object.
  Future<void> getUserData(String id) async {
    DocumentSnapshot<Map<String, dynamic>>? doc;
    try {
      doc = await _ref.doc(id).get();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    user.value = Users.fromJson(doc!.data()!, uid: doc.id);
    update();
  }

  /// Logout the currently logged user and remove it's info.
  void logout() async {
    await FirebaseAuth.instance.signOut();
    user.value = null;
  }

  /// Check if user has verified his email.
  bool emailVerified(User user) {
    if (user.emailVerified) {
      return true;
    } else {
      user.sendEmailVerification();
      FirebaseAuth.instance.signOut();
      return false;
    }
  }

  /// Takes the image user select and upload it to firebase storage
  ///
  /// Then it refrence it in user document if firestore.
  void updateUserPhoto(XFile image) async {
    var current = user.value!;
    var path = "profile_pictures/${current.id!}";
    Get.dialog(const LoadingCard(), barrierDismissible: false);
    try {
      TaskSnapshot snapshot = await storageRef.child(path).putFile(File(image.path));
      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) throw "There was an error durring upload";
      if (snapshot.state == TaskState.success) {
        var imageUrl = await snapshot.ref.getDownloadURL();
        Map<String, dynamic> data = {
          "photo": imageUrl
        };

        updateUserData(data);
      }
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
    Get.back();
  }

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user != null) {
          if (emailVerified(user)) {
            // got to home.
            getUserData(user.uid).then((value) => Get.offAllNamed(AppLinks.events));
          } else {
            // stay in login.
            Get.showSnackbar(errorCard("Please check your email."));
          }
        } else {
          // go to login.
          Get.offAllNamed(AppLinks.getStarted);
        }
      },
    );
    super.onInit();
  }
}
