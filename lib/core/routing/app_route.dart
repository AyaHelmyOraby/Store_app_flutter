import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../features/login/presentation/login_screen.dart';
import '../../features/views/product_screen.dart';
import "routes.dart";

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const ProductScreen()); // ✅

      case Routes.loginscreen:
        return MaterialPageRoute(builder: (_) =>  LoginScreen()); // ✅

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}

