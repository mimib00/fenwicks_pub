import 'package:fenwicks_pub/controller/discover_controller/post_details_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostDetailsController>(
      init: PostDetailsController(),
      builder: (controller) {
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
                    flexibleSpace: postImages(controller),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CommentsTiles(
                          isNewComment: index == 0 ? true : false,
                          profileImage: kDummyUser,
                          name: 'Michael Bruno',
                          comment:
                              'Cras gravida bibendum dolor eu varius. Ipsum fermentum velit nisl, eget vehicula.',
                          time: '8h ago',
                          like: 12,
                        );
                      },
                      childCount: 10,
                    ),
                  ),
                ],
              ),
              writeComment(),
            ],
          ),
        );
      },
    );
  }

  Widget writeComment() {
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
              child: Image.asset(
                kDummyUser,
                height: 47,
              ),
            ),
            title: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: TextFormField(
                cursorColor: kSecondaryColor,
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

  Widget postImages(PostDetailsController controller) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              PageView.builder(
                controller: controller.pageController,
                itemCount: controller.getPostImage.length,
                onPageChanged: (index) => controller.currentPage(index),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    controller.getPostImage[index],
                    fit: BoxFit.cover,
                    height: Get.height,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: controller.pageController,
                    // PageController
                    count: controller.getPostImage.length,
                    effect: WormEffect(
                      dotHeight: 6.13,
                      dotWidth: 6.13,
                      dotColor: kWhiteColor.withOpacity(0.43),
                      activeDotColor: kSecondaryColor,
                    ),
                    // your preferred effect
                    onDotClicked: (index) => controller.currentPage(index),
                  ),
                ),
              ),
            ],
          ),
        ),
        likeCommentShare(),
      ],
    );
  }

  Widget likeCommentShare() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    kLike,
                    color: kRedColor,
                    height: 19.79,
                  ),
                  MyText(
                    text: '247',
                    size: 12,
                    paddingLeft: 5,
                    paddingBottom: 5,
                    weight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ],
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
                      text: '57',
                      size: 12,
                      paddingLeft: 5,
                      paddingBottom: 5,
                      weight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    kShare,
                    height: 19.64,
                  ),
                  MyText(
                    text: '33',
                    size: 12,
                    paddingLeft: 5,
                    paddingBottom: 5,
                    weight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            kBookMark,
            height: 21.83,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CommentsTiles extends StatelessWidget {
  CommentsTiles({
    Key? key,
    this.isNewComment = false,
    this.profileImage,
    this.name,
    this.comment,
    this.time,
    this.like,
  }) : super(key: key);
  bool? isNewComment;
  String? profileImage, name, comment, time;
  int? like;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          color: isNewComment == true
              ? kGreyColor4.withOpacity(0.10)
              : Colors.transparent,
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
                    height: isNewComment == true ? 53.75 : 49,
                    width: isNewComment == true ? 53.75 : 49,
                    padding: EdgeInsets.all(isNewComment == true ? 0 : 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color:
                            isNewComment == true ? kWhiteColor : kSkyBlueColor,
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
                  isNewComment == true
                      ? const SizedBox()
                      : Column(
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  kLike,
                                  color: kRedColor,
                                  height: 10.53,
                                ),
                                MyText(
                                  paddingLeft: 5,
                                  text: '$like',
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
                        text: '$name',
                        size: 17,
                        weight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                      MyText(
                        paddingTop: 5,
                        text: '$comment',
                        size: 12,
                        color: isNewComment == true
                            ? kWhiteColor.withOpacity(0.58)
                            : kWhiteColor,
                        fontFamily: 'Poppins',
                      ),
                    ],
                  ),
                ),
              ),
              MyText(
                text: '$time',
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
    );
  }
}
