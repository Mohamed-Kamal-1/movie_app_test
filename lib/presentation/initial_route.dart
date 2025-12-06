import 'package:flutter/material.dart';

import '../SharedPreferences/auth_shared_preferences.dart';
import '../core/routes/app_routes.dart';

class InitialRoute extends StatefulWidget {
  const InitialRoute({super.key});

  @override
  State<InitialRoute> createState() => _InitialRouteState();
}

class _InitialRouteState extends State<InitialRoute> {
  @override
  void initState() {
    super.initState();
    _determineInitialRoute();
  }

  Future<void> _determineInitialRoute() async {
    final isFirstTime = await AuthSharedPreferences.isFirstTime();

    final token = AuthSharedPreferences.getToken();

    if (!mounted) return;

    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, AppRoutes.OnBoardingScreen.name);
    } else if (token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.LoginScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.HomeTab.name);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
