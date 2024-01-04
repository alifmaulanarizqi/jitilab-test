import 'package:flutter/material.dart';
import 'package:jitilab_test/src/splash/presenation/splash_page.dart';
import 'package:jitilab_test/src/user/presentation/list_user/list_user_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.Up
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jitilab Test',
      theme: ThemeData(
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (ctx) => const SplashPage(),
        ListUserPage.route: (ctx) => const ListUserPage(),
      },
    );
  }
}