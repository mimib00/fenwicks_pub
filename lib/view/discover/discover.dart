import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/controller/post_controller.dart';
import 'package:fenwicks_pub/model/post.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/discover/add_post.dart';
import 'package:fenwicks_pub/view/discover/post_details.dart';
import 'package:fenwicks_pub/view/drawer/my_drawer.dart';
import 'package:fenwicks_pub/view/profile/discover_profile.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  Future<List<Posts>> getOwner(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    List<Posts> posts = [];
    try {
      for (var doc in docs) {
        DocumentReference<Map<String, dynamic>> ref = doc.data()["owner"];
        final temp = await ref.get();
        final user = Users.fromJson(temp.data()!, uid: temp.id);
        var map = doc.data();
        map["owner"] = user;

        posts.add(Posts.fromJson(map, id: doc.id));
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      child: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              discoverHeader(),
              const SizedBox(height: 15),
              GetBuilder<PostController>(
                init: PostController(),
                builder: (controller) {
                  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.getPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null || snapshot.data!.docs.isEmpty) return Container();
                      return FutureBuilder<List<Posts>>(
                        future: getOwner(snapshot.data!.docs),
                        builder: (context, snapshot) {
                          if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data![index];
                              return Post(post: post);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 15,
            child: floatingActionButton(() {
              Get.to(() => AddPost());
            }),
          ),
        ],
      ),
    );
  }

  Widget discoverHeader() {
    return GetBuilder<AuthController>(builder: (controller) {
      final user = controller.user.value!;
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
                  text: 'Discover',
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
            GestureDetector(
              onTap: () => Get.to(() => const DiscoverProfile()),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: CachedNetworkImage(
                  imageUrl: user.photo,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 50,
                  errorWidget: (_, __, ___) => const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget floatingActionButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 60.35,
        width: 60.35,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.83),
              offset: const Offset(0, 7),
              blurRadius: 30,
            ),
          ],
          borderRadius: BorderRadius.circular(100),
          color: kWhiteColor.withOpacity(0.14),
        ),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: kBlackColor,
          ),
          child: Center(
            child: Image.asset(
              kAddIcon,
              height: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget discoverPeoples(String profileImage, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: kSecondaryColor,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                profileImage,
                height: Get.height,
              ),
            ),
          ),
          MyText(
            paddingLeft: 10,
            text: name,
            size: 10,
            color: kWhiteColor.withOpacity(0.8),
            fontFamily: 'Poppins',
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Post extends StatelessWidget {
  final Posts post;
  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final user = authController.user.value!;
    bool isSaved = user.saved.isNotEmpty ? user.saved.where((element) => element == FirebaseFirestore.instance.collection("posts").doc(post.id)).isNotEmpty : false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: CachedNetworkImage(
                imageUrl: post.owner.photo,
                fit: BoxFit.cover,
                height: 60,
                width: 50,
                errorWidget: (_, __, ___) => const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: MyText(
              text: post.owner.name,
              size: 16,
              weight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            subtitle: MyText(
              text: DateFormat.yMMMMd().format(post.createdAt.toDate()),
              size: 11,
              color: kGreyColor3,
              fontFamily: 'Poppins',
            ),
            trailing: GetBuilder<PostController>(builder: (controller) {
              return IconButton(
                onPressed: () {
                  controller.bookmark(post.id!);
                },
                icon: Icon(
                  isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  color: kSecondaryColor,
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (post.photo.isNotEmpty) {
                Get.to(() => PostDetails(post: post));
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: post.caption.isNotEmpty,
                  child: MyText(
                    text: post.caption,
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: post.photo.isNotEmpty,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: post.photo,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          likeComment(),
        ],
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
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
        );
      },
    );
  }
}
