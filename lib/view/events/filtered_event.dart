import 'package:fenwicks_pub/controller/event_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/view/events/events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/back_button.dart';

class FilteredEvents extends StatefulWidget {
  final EventTypes type;
  final String title;
  const FilteredEvents({
    Key? key,
    required this.type,
    required this.title,
  }) : super(key: key);

  @override
  State<FilteredEvents> createState() => _FilteredEventsState();
}

class _FilteredEventsState extends State<FilteredEvents> {
  late List<EventModel> events = [];

  final EventController controller = Get.find<EventController>();

  @override
  void initState() {
    events.addAll(controller.events.where((p0) => p0.type == widget.type).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 30),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return RecentEventsWidget(event: events[index]);
        },
      ),
    );
  }
}
