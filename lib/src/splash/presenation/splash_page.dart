import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common_ui/utils/colors/common_colors.dart';
import '../../user/presentation/list_user/list_user_page.dart';

class SplashPage extends StatefulWidget {
  static const route = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var splashDuration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();

    Future.delayed(splashDuration).then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          ListUserPage.route, (Route<dynamic> route) => false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.blueE9,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Image.asset(
              'assets/images/logo.png',
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}