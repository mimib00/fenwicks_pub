import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/post.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/discover/discover.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  Future<Posts> getPost(DocumentReference<Map<String, dynamic>> ref) async {
    Posts? post;
    try {
      final doc = await ref.get();
      DocumentReference<Map<String, dynamic>> user = doc.data()!["owner"];
      final temp = await user.get();
      final info = Users.fromJson(temp.data()!, uid: temp.id);
      var map = doc.data()!;
      map["owner"] = info;

      post = Posts.fromJson(map, id: doc.id);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return post!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        title: MyText(
          text: 'Saved Posts',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          discoverHeader(),
          GetBuilder<AuthController>(
            builder: (controller) {
              final user = controller.user.value!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemCount: user.saved.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<Posts>(
                    future: getPost(user.saved[index]),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) return Container();
                      return Post(post: snapshot.data!);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget discoverHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                text: 'Bookmarked',
                paddingRight: 15,
                paddingBottom: 6,
                size: 33,
                weight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
              Image.asset(
                kCircle,
                height: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
