import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/controller/post_controller.dart';
import 'package:fenwicks_pub/model/post.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class PostDetails extends StatelessWidget {
  final Posts post;
  const PostDetails({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                leading: backButton(),
                expandedHeight: 410,
                floating: true,
                flexibleSpace: postImages(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final comment = post.comments[index];
                    return CommentsTiles(comment: comment, id: post.id!);
                  },
                  childCount: post.comments.length,
                ),
              ),
            ],
          ),
          writeComment(),
        ],
      ),
    );
  }

  Widget writeComment() {
    final AuthController authController = Get.find();
    final user = authController.user.value!;
    final PostController postController = Get.find();
    final TextEditingController controller = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: kPrimaryColor,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: user.photo,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
                errorWidget: (_, __, ___) => const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: TextField(
                controller: controller,
                cursorColor: kSecondaryColor,
                onSubmitted: (value) {
                  Map<String, dynamic> comment = {
                    "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
                    "comment": value.trim(),
                    "created_at": Timestamp.now(),
                    "likes": [],
                  };
                  postController.comment(post.id!, comment).then((value) => controller.clear());
                },
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  color: kGreyColor,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  hintText: 'Add a comment',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    color: kGreyColor,
                  ),
                  filled: true,
                  fillColor: kSkyBlueColor2.withOpacity(0.06),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget postImages() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              PageView.builder(
                controller: PageController(),
                itemCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.photo,
                    fit: BoxFit.cover,
                    height: 300,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
        likeComment(),
      ],
    );
  }

  Widget likeComment() {
    final AuthController authController = Get.find();
    final user = authController.user.value!;

    bool isLiked = post.likes.isNotEmpty ? post.likes.where((element) => element == FirebaseFirestore.instance.collection("users").doc(user.id)).isNotEmpty : false;

    return GetBuilder<PostController>(
      init: PostController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isLiked) {
                        controller.unLikePost(post.id!, user.id!);
                      } else {
                        controller.likePost(post.id!, user.id!);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 28,
                          color: isLiked ? kRedColor : kSecondaryColor,
                        ),
                        MyText(
                          text: post.likes.length.toString(),
                          size: 12,
                          paddingLeft: 5,
                          paddingBottom: 5,
                          color: kSecondaryColor,
                          weight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          kComment,
                          height: 19.95,
                        ),
                        MyText(
                          text: post.comments.length.toString(),
                          size: 12,
                          paddingLeft: 5,
                          paddingBottom: 5,
                          color: kSecondaryColor,
                          weight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Image.asset(
              //   kBookMark,
              //   height: 21.83,
              // ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_outline,
                  size: 28,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class CommentsTiles extends StatelessWidget {
  final Map<String, dynamic> comment;
  final String id;
  const CommentsTiles({
    Key? key,
    required this.comment,
    required this.id,
  }) : super(key: key);

  Future<Users> getOwner(DocumentReference<Map<String, dynamic>> ref) async {
    Users? user;
    try {
      final info = await ref.get();
      user = Users.fromJson(info.data()!, uid: info.id);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return user!;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      init: PostController(),
      builder: (controller) {
        return FutureBuilder<Users>(
          future: getOwner(comment["owner"]),
          builder: (context, snapshot) {
            if (snapshot.data == null) return Container();
            final owner = snapshot.data!;
            final likes = comment['likes'].cast<DocumentReference>();

            final AuthController authController = Get.find();
            final user = authController.user.value!;

            bool isLiked = likes.isNotEmpty ? likes.where((element) => element == FirebaseFirestore.instance.collection("users").doc(user.id)).isNotEmpty : false;
            return GestureDetector(
              onDoubleTap: () {
                if (isLiked) {
                  controller.unLikeComment(id, comment, user.id!);
                } else {
                  controller.likeComment(id, comment, user.id!);
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              height: 49,
                              width: 49,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: kSkyBlueColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  kDummyUser,
                                  height: Get.height,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 15,
                                      color: isLiked ? kRedColor : kSecondaryColor,
                                    ),
                                    MyText(
                                      paddingLeft: 5,
                                      text: likes.length,
                                      size: 9,
                                      color: kSkyBlueColor2,
                                      fontFamily: 'Poppins',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MyText(
                                  text: owner.name,
                                  size: 17,
                                  weight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                                MyText(
                                  paddingTop: 5,
                                  text: comment["comment"],
                                  size: 12,
                                  color: kWhiteColor,
                                  fontFamily: 'Poppins',
                                ),
                              ],
                            ),
                          ),
                        ),
                        MyText(
                          text: Jiffy(comment["created_at"].toDate().toString()).fromNow(),
                          size: 10,
                          color: kWhiteColor.withOpacity(0.67),
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    height: 1,
                    color: kSecondaryColor.withOpacity(0.22),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
