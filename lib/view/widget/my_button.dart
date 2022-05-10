import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    this.text,
    this.onTap,
  }) : super(key: key);

  String? text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.71,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: kWhiteColor.withOpacity(0.5),
          width: 2.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        splashColor: kWhiteColor.withOpacity(0.05),
        highlightColor: kWhiteColor.withOpacity(0.05),
        child: Center(
          child: MyText(
            text: '$text'.toUpperCase(),
            size: 20,
            weight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var text, weight, textColor, btnBgColor, radius,fontFamily;
  double? textSize, height, elevation;
  VoidCallback? onPressed;

  CustomButton({
    Key? key,
    this.text,
    this.textSize = 18,
    this.height = 62,
    this.fontFamily = 'Poppins',
    this.weight = FontWeight.w500,
    this.textColor = kWhiteColor,
    this.btnBgColor = kSecondaryColor,
    this.elevation = 0,
    this.radius = 10.0,
    this.onPressed,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: widget.elevation,
      highlightElevation: widget.elevation,
      onPressed: widget.onPressed,
      color: widget.btnBgColor,
      splashColor: kWhiteColor.withOpacity(0.1),
      highlightColor: kWhiteColor.withOpacity(0.1),
      height: widget.height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Text(
        '${widget.text}',
        style: TextStyle(
          fontSize: widget.textSize,
          color: widget.textColor,
          fontWeight: widget.weight,
          fontFamily: widget.fontFamily,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
