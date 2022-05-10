import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var hintText;
  bool? obSecure;
  double? paddingBottom, contentPadding;
  TextEditingController? controller = TextEditingController();
  ValueChanged<String>? onChanged;

  MyTextField({
    Key? key,
    this.hintText,
    this.onChanged,
    this.controller,
    this.obSecure = false,
    this.paddingBottom = 15.0,
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
