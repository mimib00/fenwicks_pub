import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: DatePicker(
          DateTime.now(),
          height: 80,
          width: 48,
          controller: _controller,
          initialSelectedDate: DateTime.now(),
          selectionColor: kSecondaryColor,
          deactivatedColor: kWhiteColor,
          monthTextStyle: const TextStyle(
            color: kWhiteColor,
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          dateTextStyle: const TextStyle(
            color: kWhiteColor,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          dayTextStyle: const TextStyle(
            color: kWhiteColor,
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          selectedTextColor: kWhiteColor,
          onDateChange: (date) {
            // New date selected
            setState(() {});
          },
        ),
      ),
    );
  }
}
