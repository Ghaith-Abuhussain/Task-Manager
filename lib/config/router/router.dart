import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../presentation/views/home_screen.dart';
import '../../presentation/views/login_screen.dart';


Route<dynamic>? GeneratedRoutes(RouteSettings settings, BuildContext context) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return PageTransition(
        child: LoginScreen(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 500),
      );
    case HomeScreen.routeName:
      return PageTransition(
        child: HomeScreen(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 500),
      );
    default:
      return null;
  }
}

void navigateToRoute(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}

void navigateToRouteReplacement(BuildContext context, String route) {
  Navigator.pushReplacementNamed(context, route);
}

void navigateToPrevious(BuildContext context) {
  Navigator.pop(context);
}
