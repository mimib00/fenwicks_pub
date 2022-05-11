import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class AuthController extends GetxController {
  final _ref = FirebaseFirestore.instance.collection("users");

  /// login the user.
  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  /// create a user in firebase authentication.
  void register(Users user, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    saveUserData(user);
  }

  /// Svae user data to a firestore collection call users
  void saveUserData(Users user) async {
    User userCredential = FirebaseAuth.instance.currentUser!;
    try {
      _ref.doc(userCredential.uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    userCredential.sendEmailVerification();
    logout();
    Get.showSnackbar(messageCard("Check email and verify email"));
  }

  /// fetch user data from firestore and cast it to a [Users] object.
  void getUserData() async {}

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  /// Check if user has verified his email.
  bool emailVerified(User user) {
    if (user.emailVerified) {
      return true;
    } else {
      FirebaseAuth.instance.signOut();
      return false;
    }
  }

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        if (emailVerified(user)) {
          // got to home.
          // TODO: get user data.
          Get.offAllNamed(AppLinks.events);
        } else {
          // stay in login.
          Get.showSnackbar(errorCard("Please check your email."));
        }
      } else {
        // go to login.
        Get.offAllNamed(AppLinks.getStarted);
      }
    });
    super.onInit();
  }
}
