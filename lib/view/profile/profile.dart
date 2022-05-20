import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/my_text_field.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      final user = controller.user.value!;

      user.history.sort(
        (a, b) {
          if (a["date"] == null || b["date"] == null) return 0;
          final first = a["date"] as Timestamp;
          final second = b["date"] as Timestamp;

          return first.compareTo(second);
        },
      );

      final history = user.history;
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.only(
                top: 35,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kBlurEffect),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Image.asset(
                            kArrowBack,
                            color: kWhiteColor,
                            height: 14.25,
                          ),
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            kNotificationIcon,
                            height: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            kMenuIcon,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      controller.updateUserPhoto(image);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: CachedNetworkImage(
                        imageUrl: user.photo,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                        errorWidget: (_, __, ___) => const CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Icons.person_rounded,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  MyText(
                    paddingTop: 20,
                    text: user.name,
                    size: 21,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ],
              ),
            ),
            Positioned(
              top: 280,
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kClippedEffect),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  children: [
                    const SizedBox(
                      height: 80,
                    ),

                    ProfileTiles(
                      title: 'Name',
                      field: "name",
                      value: user.name,
                    ),
                    ProfileTiles(
                      title: 'Email',
                      field: "email",
                      value: user.email,
                    ),
                    // ProfileTiles(
                    //   controller: tabController,
                    //   title: 'Password',
                    //   value: '*********',
                    //   onTap: () {
                    //     tabController.animateTo(1);
                    //     setState(() {
                    //       _title = "Change Password";
                    //       _label = "New Password";
                    //       _field = "password";
                    //     });
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Reward History',
                            size: 16,
                            weight: FontWeight.w700,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppLinks.rewardHistory),
                            child: MyText(
                              text: 'View All',
                              size: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: totalRewardPoints(user.points),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: history.length > 5 ? 5 : history.length,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      itemBuilder: (context, index) {
                        final date = history[index]["date"] as Timestamp;
                        final doc = history[index]["event"] as DocumentReference<Map<String, dynamic>>;
                        return PRewardHistoryTiles(date: date.toDate(), doc: doc);
                      },
                    ),
                    const SizedBox(
                      height: 250,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

// class InfoEditor extends StatelessWidget {
//   InfoEditor({
//     Key? key,
//   }) : super(key: key);

//   final TextEditingController controller = TextEditingController();
//   final TextEditingController controller2 = TextEditingController();
//   final TextEditingController password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// ignore: must_be_immutable
class ProfileTiles extends StatelessWidget {
  final String title;
  final String value;
  final String field;

  ProfileTiles({
    Key? key,
    required this.title,
    required this.value,
    required this.field,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final TextEditingController password = TextEditingController();

  final AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: "Update $title",
          content: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: title,
                ),
              ),
              Visibility(
                visible: field == "email",
                child: TextField(
                  controller: password,
                  decoration: const InputDecoration(
                    hintText: "Current Password",
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;
                  if (controller.text.trim().isEmail && password.text.trim().isNotEmpty) {
                    // update email
                    auth.updateEmail(controller.text.trim(), password.text.trim());
                  }
                  Map<String, dynamic> data = {
                    field: controller.text.trim()
                  };
                  auth.updateUserData(data);
                },
                child: const Text("Update"),
              )
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: title,
                  size: 11,
                  fontFamily: 'Poppins',
                ),
                MyText(
                  text: value,
                  size: 16,
                  weight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 15,
              ),
              height: 2,
              decoration: BoxDecoration(
                color: kWhiteColor.withOpacity(0.42),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PRewardHistoryTiles extends StatelessWidget {
  final DateTime date;
  final DocumentReference<Map<String, dynamic>> doc;
  const PRewardHistoryTiles({
    Key? key,
    required this.date,
    required this.doc,
  }) : super(key: key);

  Future<EventModel> getEvent() async {
    DocumentSnapshot<Map<String, dynamic>>? snap;
    try {
      snap = await doc.get();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }

    return EventModel.fromJson(snap!.data()!, uid: snap.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventModel>(
        future: getEvent(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();

          final event = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              left: 15,
              right: 15,
            ),
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                minLeadingWidth: 25,
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                tileColor: kBlackColor,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kCoin3,
                      height: 25.84,
                    ),
                  ],
                ),
                title: MyText(
                  paddingBottom: 7,
                  text: 'Total Reward : ${event.points} Points',
                  size: 17,
                  weight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                subtitle: MyText(
                  text: '${event.points} points rewarded on going on event\n"${event.name}"',
                  size: 11,
                  maxLines: 2,
                  overFlow: TextOverflow.ellipsis,
                  fontFamily: 'Poppins',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyText(
                      height: 1.1,
                      text: date.day.toString(),
                      size: 37,
                      color: kSecondaryColor,
                      weight: FontWeight.w900,
                      fontFamily: 'Poppins',
                    ),
                    MyText(
                      text: DateFormat.yMMM().format(date),
                      size: 9,
                      color: kSecondaryColor,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
