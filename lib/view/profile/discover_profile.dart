import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/post.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/profile/saved_posts.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class DiscoverProfile extends StatelessWidget {
  const DiscoverProfile({Key? key}) : super(key: key);

  Future<List<Posts>> getPosts(List<DocumentReference<Map<String, dynamic>>> docs) async {
    List<Posts> posts = [];
    try {
      for (var doc in docs) {
        final post = await doc.get();
        DocumentReference<Map<String, dynamic>> ref = post.data()!["owner"];
        final temp = await ref.get();
        final user = Users.fromJson(temp.data()!, uid: temp.id);
        var map = post.data()!;
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
    return GetBuilder<AuthController>(
      builder: (controller) {
        final user = controller.user.value;
        return Scaffold(
          appBar: AppBar(
            leading: backButton(),
            actions: [
              IconButton(
                onPressed: () => Get.to(() => const SavedScreen()),
                icon: const Icon(
                  Icons.bookmark_rounded,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileCard(user: user),
              const SizedBox(height: 60),
              FutureBuilder<List<Posts>>(
                future: getPosts(user?.posts ?? []),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                  final posts = snapshot.data!.where((element) => element.photo.isNotEmpty).toList();
                  return StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    physics: const BouncingScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: posts.length,
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(
                        index == 4 ? 2 : 1,
                        index == 4 ? 2.3 : 1.0,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: posts[index].photo,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Users? user;
  const ProfileCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: kWhiteColor,
                  width: 4,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: user?.photo ?? "",
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                  errorWidget: (_, __, ___) => const CircleAvatar(
                    radius: 60,
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      Icons.person_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                text: user?.name ?? "",
                size: 21,
                weight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: user != null && user!.address.isNotEmpty ? user!.address.first["address"] : "",
                size: 14,
                color: kSecondaryColor,
                fontFamily: 'Poppins',
                paddingBottom: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
