import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool? obSecure;
  final double? paddingBottom, contentPadding;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  const MyTextField({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.obSecure = false,
    this.paddingBottom = 15.0,
    this.contentPadding,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.paddingBottom!,
      ),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: kWhiteColor.withOpacity(0.5),
        onChanged: widget.onChanged,
        style: TextStyle(
          color: kWhiteColor.withOpacity(0.5),
          fontSize: 18,
          fontWeight: FontWeight.w300,
          fontFamily: 'Open Sans',
        ),
        obscureText: widget.obSecure!,
        obscuringCharacter: "*",
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: kWhiteColor.withOpacity(0.5),
            fontSize: 18,
            fontWeight: FontWeight.w300,
            fontFamily: 'Open Sans',
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kWhiteColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kWhiteColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
