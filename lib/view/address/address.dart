import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/custom_app_bar.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Address extends StatelessWidget {
  Address({
    Key? key,
    this.price,
  }) : super(key: key);
  int? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(
        title: 'Address',
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          final user = controller.user.value;
          if (user == null) {
            return Container();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: user.address.length,
            itemBuilder: (context, index) {
              final address = user.address[index];
              return AddressCards(
                isBusiness: address["address_type"] == "Work",
                address: address,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        child: Image.asset(
          kAddIcon,
          height: 18,
        ),
        onPressed: () => Get.to(() => const AddressScreen()),
      ),
    );
  }
}

class AddressCards extends StatelessWidget {
  final Map<String, dynamic> address;
  final bool? isBusiness;
  const AddressCards({
    Key? key,
    required this.address,
    this.isBusiness = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      height: 117,
      decoration: BoxDecoration(
        color: isBusiness == true ? kWhiteColor : kBlackColor,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(0.16),
            offset: const Offset(0, 19),
            blurRadius: 22,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final ShopController controller = Get.find();
            controller.selectAddress(address["address"]);
            Get.toNamed(AppLinks.payment);
          },
          borderRadius: BorderRadius.circular(21),
          splashColor: isBusiness == true ? kBlackColor.withOpacity(0.1) : kWhiteColor.withOpacity(0.1),
          highlightColor: isBusiness == true ? kBlackColor.withOpacity(0.1) : kWhiteColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            isBusiness == true ? kBusinessIcon : kHomeIcon,
                            height: 14,
                          ),
                          MyText(
                            paddingLeft: 6,
                            text: isBusiness == true ? 'Work' : 'Home',
                            size: 16,
                            color: isBusiness == true ? kBlackColor : kWhiteColor,
                            weight: FontWeight.w700,
                          ),
                        ],
                      ),
                      MyText(
                        paddingTop: 10,
                        text: address["address"],
                        size: 12,
                        weight: FontWeight.w400,
                        color: isBusiness == true ? kBlackColor.withOpacity(0.46) : kWhiteColor,
                        fontFamily: 'Poppins',
                      ),
                    ],
                  ),
                ),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        controller.removeAddress(address);
                      },
                      child: const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BagTiles extends StatelessWidget {
  BagTiles({
    Key? key,
    this.drinkName,
    this.oldPrice,
    this.newPrice,
    this.haveDiscount = false,
  }) : super(key: key);
  String? drinkName;
  int? oldPrice, newPrice;
  bool? haveDiscount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 40,
          ),
          height: 94,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kBlackColor,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 110,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyText(
                      paddingBottom: 10,
                      text: '$drinkName',
                      size: 12,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    Row(
                      children: [
                        MyText(
                          paddingRight: 15,
                          text: '\$$newPrice',
                          size: 11,
                          weight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        haveDiscount == true
                            ? MyText(
                                text: '\$$oldPrice',
                                size: 9,
                                weight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                color: kSecondaryColor,
                                fontFamily: 'Poppins',
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: 20,
                ),
                height: 28.83,
                width: 73.82,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: kBlackColor.withOpacity(0.10),
                      offset: const Offset(0, 3),
                      blurRadius: 25,
                    ),
                  ],
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      kRemoveIcon,
                      height: 3,
                    ),
                    MyText(
                      text: '2',
                      size: 14,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    Image.asset(
                      kAddIcon,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -65,
          left: -33,
          child: Image.asset(
            kBearGlass,
            height: 175,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String dropValue = "Home";

  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(
        title: 'Add Address',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: "Address type: ",
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5),
                  DropdownButton<String>(
                    value: dropValue,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                        value: "Home",
                        child: Text(
                          "Home",
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Work",
                        child: Text(
                          "Work",
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        dropValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyTextField(
              hintText: 'Address',
              paddingBottom: 30.0,
              keyboardType: TextInputType.streetAddress,
              controller: address,
            ),
            MyButton(
              text: "Add Address",
              onTap: () {
                final AuthController auth = Get.find();
                if (address.text.isEmpty) return;

                Map<String, dynamic> data = {
                  "address_type": dropValue,
                  "address": address.text.trim(),
                };

                auth.addAddress(data);
              },
            )
          ],
        ),
      ),
    );
  }
}
