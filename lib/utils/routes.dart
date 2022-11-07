import 'package:chatty/screens/auth/splash_screen.dart';
import 'package:chatty/screens/home/home_screen.dart';
import 'package:chatty/screens/login_screen.dart';
import 'package:chatty/screens/sign_up_screen.dart';
import 'package:chatty/utils/route_names.dart';

import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      // ignore: no_duplicate_case_values
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      // ignore: no_duplicate_case_values
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RouteNames.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('Wrong Route Called'),
              ),
            );
          },
        );
    }
  }
}
