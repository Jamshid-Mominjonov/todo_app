import 'package:flutter/material.dart';
import 'package:todo_app/core/route/route_names.dart';
import '../../views/pages/home/dashboard_page.dart';
import '../../views/pages/home/onboarding_page.dart';
import '../../views/pages/auth/sign_in_page.dart';
import '../../views/pages/auth/sign_up_page.dart';
import '../../views/pages/home/task_page.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.onBoardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case RouteNames.signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteNames.dashboardPage:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case RouteNames.taskPage:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found")),
      ),
    );
  }
}
