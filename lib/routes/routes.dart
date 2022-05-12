import 'package:fenwicks_pub/view/address/address.dart';
import 'package:fenwicks_pub/view/claim_your_reward/claim_your_reward.dart';
import 'package:fenwicks_pub/view/claim_your_reward/verify_password.dart';
import 'package:fenwicks_pub/view/discover/discover.dart';
import 'package:fenwicks_pub/view/events/events.dart';
import 'package:fenwicks_pub/view/events/events_detail_view.dart';
import 'package:fenwicks_pub/view/launch/new_get_started.dart';
import 'package:fenwicks_pub/view/launch/splash_screen.dart';
import 'package:fenwicks_pub/view/payment/payment.dart';
import 'package:fenwicks_pub/view/payment/purchase_successful.dart';
import 'package:fenwicks_pub/view/product_details/product_details.dart';
import 'package:fenwicks_pub/view/profile/discover_profile.dart';
import 'package:fenwicks_pub/view/profile/profile.dart';
import 'package:fenwicks_pub/view/reward_history/reward_history.dart';
import 'package:fenwicks_pub/view/top_sale_and_future_products/top_sale_and_future_products.dart';
import 'package:fenwicks_pub/view/user/auth_screen.dart';
import 'package:fenwicks_pub/view/your_bag/your_bag.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: AppLinks.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppLinks.getStarted,
      page: () => const NewGetStarted(),
    ),
    GetPage(
      name: AppLinks.auth,
      page: () => const AuthScreen(),
    ),
    GetPage(
      name: AppLinks.events,
      page: () => const Events(),
    ),
    GetPage(
      name: AppLinks.eventsDetailView,
      page: () => const EventsDetailView(),
    ),
    GetPage(
      name: AppLinks.topSaleAndFutureProducts,
      page: () => const TopSaleAndFutureProducts(),
    ),
    GetPage(
      name: AppLinks.productDetails,
      page: () => const ProductDetails(),
    ),
    GetPage(
      name: AppLinks.yourBag,
      page: () => YourBag(),
    ),
    GetPage(
      name: AppLinks.address,
      page: () => Address(),
    ),
    GetPage(
      name: AppLinks.payment,
      page: () => const Payment(),
    ),
    GetPage(
      name: AppLinks.purchaseSuccessful,
      page: () => const PurchaseSuccessful(),
    ),
    GetPage(
      name: AppLinks.claimYourReward,
      page: () => const ClaimYourReward(),
    ),
    GetPage(
      name: AppLinks.verifyPassword,
      page: () => const VerifyPassword(),
    ),
    GetPage(
      name: AppLinks.profile,
      page: () => const Profile(),
    ),
    GetPage(
      name: AppLinks.discoverProfile,
      page: () => const DiscoverProfile(),
    ),
    GetPage(
      name: AppLinks.discover,
      page: () => const Discover(),
    ),
    GetPage(
      name: AppLinks.rewardHistory,
      page: () => const RewardHistory(),
    ),
  ];
}

class AppLinks {
  static const splashScreen = '/splash_screen';
  static const getStarted = '/get_started';
  static const auth = '/auth';
  // static const login = '/login';
  // static const signUp = '/sign_up';
  static const events = '/events';
  static const eventsDetailView = '/events_detail_view';
  static const topSaleAndFutureProducts = '/top_sale_and_future_products';
  static const productDetails = '/product_details';
  static const yourBag = '/your_bag';
  static const address = '/address';
  static const payment = '/payment';
  static const purchaseSuccessful = '/purchase_successful';
  static const claimYourReward = '/claim_your_reward';
  static const verifyPassword = '/verify_password';
  static const profile = '/profile';
  static const discoverProfile = '/discover_profile';
  static const discover = '/discover';
  static const rewardHistory = '/reward_history';
}
