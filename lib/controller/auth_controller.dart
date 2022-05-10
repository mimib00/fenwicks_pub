import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _ref = FirebaseFirestore.instance.collection("users");

  void login() async {}

  void register() async {
    // UserCredential userCredential;

    // userCredential.user
  }

  void getUserData() async {}

  void logout() {}
}
