import 'package:flutter/material.dart';
import 'package:project_test/utils/app_routes.dart';
import 'package:project_test/views/pages/login_page.dart';
import 'package:project_test/views/pages/signup_page.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
          settings: settings,
        );
      
        case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error Page!'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
