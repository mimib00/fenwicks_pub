import 'package:fenwicks_pub/view/user/login.dart';
import 'package:fenwicks_pub/view/user/sign_up.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController controller;
  List<Widget> screens = [];

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this, initialIndex: 0);
    screens = [
      Login(controller: controller),
      SignUp(controller: controller)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
    );
  }
}
