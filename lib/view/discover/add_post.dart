import 'dart:io';

import 'package:fenwicks_pub/controller/post_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);

  final TextEditingController caption = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: backButton(),
              title: MyText(
                text: 'Add Post',
                size: 18,
                weight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectImage();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: controller.image == null
                        ? Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: kGreyColor3, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 50,
                                  color: kGreyColor3,
                                ),
                                MyText(
                                  text: "Add a Photo",
                                  color: kGreyColor3,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.file(
                                  File(controller.image!.value!.path),
                                  height: 200,
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.removeImage();
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: const CircleAvatar(
                                    child: Icon(
                                      Icons.delete_forever_rounded,
                                      size: 20,
                                    ),
                                    radius: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 5),
                  MyText(
                    text: "Adding a photo is optional if caption is not empty",
                    color: kGreyColor3,
                    size: 10,
                    paddingLeft: 10,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: caption,
                    hintText: "Caption",
                    paddingBottom: 0,
                  ),
                  const SizedBox(height: 5),
                  MyText(
                    text: "Adding a caption is optional if image is not empty",
                    color: kGreyColor3,
                    size: 10,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomButton(
                  text: "Submit",
                  elevation: 1.5,
                  onPressed: () {
                    controller.post(caption.text.trim());
                  },
                ),
              ),
              color: kPrimaryColor,
            ),
          );
        });
  }
}
