import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _ref = FirebaseFirestore.instance.collection("users");

  void login() async {}

  void register(Users user, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    saveUserData(user);
  }

  void saveUserData(Users user) async {
    User userCredential = FirebaseAuth.instance.currentUser!;
    try {
      _ref.doc(userCredential.uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    userCredential.sendEmailVerification();
    logout();
  }

  void getUserData() async {}

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
