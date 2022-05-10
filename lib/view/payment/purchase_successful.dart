import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class PurchaseSuccessful extends StatelessWidget {
  const PurchaseSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            kCongrats,
            height: 297.62,
          ),
          MyText(
            paddingTop: 65,
            paddingBottom: 65,
            text: 'Thank You For Your\nPurchase!',
            size: 24,
            align: TextAlign.center,
            fontFamily: 'Poppins',
          ),
          Column(
            children: [
              MyText(
                text: 'Order Details',
                size: 16,
                weight: FontWeight.w700,
                color: kWhiteColor.withOpacity(0.76),
                align: TextAlign.center,
                fontFamily: 'Poppins',
                paddingBottom: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              title('Order Number'),
                              heading('FDK5112'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              title('DATE'),
                              heading('22/02/2021'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              title('TOTAL'),
                              heading('\$201'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              title('METHOD'),
                              heading('Credit Card'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  MyText heading(String heading) {
    return MyText(
      text: heading,
      size: 18,
      weight: FontWeight.w700,
      fontFamily: 'Poppins',
    );
  }

  MyText title(String title) {
    return MyText(
      text: title.toUpperCase(),
      size: 14,
      paddingBottom: 3,
      fontFamily: 'Poppins',
    );
  }
}
