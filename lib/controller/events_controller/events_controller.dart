import 'package:fenwicks_pub/model/events_model/events_model.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  final List<AllEventsCardModel> allEventsCardsData = [
    AllEventsCardModel(
      icon: kConcertIcon,
      title: 'Concert',
      iconSize: 23.75,
      onTap: () {},
    ),
    AllEventsCardModel(
      icon: kDrinkingIcon,
      title: 'Drinking',
      iconSize: 26.31,
      onTap: () {},
    ),
    AllEventsCardModel(
      icon: kMusicIcon,
      title: 'Dancing',
      iconSize: 23.48,
      onTap: () {},
    ),
  ];

  List<AllEventsCardModel> get getAllEventsCardsData => allEventsCardsData;

  final List<RecentEventsWidgetModel> recentEvents = [
    RecentEventsWidgetModel(
      eventName: 'Lorem ipsum dolor sit amet',
      date: 'Jan 12, 2022',
      score: '14 Reward Points',
      location: 'Green fields, Sector 42, Faridabad',
      image: 'assets/images/dummy_1.png',
    ),
    RecentEventsWidgetModel(
      eventName: 'Lorem ipsum dolor sit amet',
      date: 'Jan 12, 2022',
      score: '14 Reward Points',
      location: 'Green fields, Sector 42, Faridabad',
      image: 'assets/images/dummy_2.png',
    ),
    RecentEventsWidgetModel(
      eventName: 'Lorem ipsum dolor sit amet',
      date: 'Jan 12, 2022',
      score: '14 Reward Points',
      location: 'Green fields, Sector 42, Faridabad',
      image: 'assets/images/dummy_3.png',
    ),
    RecentEventsWidgetModel(
      eventName: 'Lorem ipsum dolor sit amet',
      date: 'Jan 12, 2022',
      score: '14 Reward Points',
      location: 'Green fields, Sector 42, Faridabad',
      image: 'assets/images/dummy_4.png',
    ),
  ];

  List<RecentEventsWidgetModel> get getRecentEvents => recentEvents;
}
