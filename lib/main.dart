import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/presentation/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/presentation/OnBoarding/on_boarding_screen.dart';
import 'package:movie_app/presentation/initial_route.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movie_app/ui/Register/register.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile_screen.dart';
import 'package:movie_app/ui/login_screen/login_screen.dart';
import 'api/my_bloc_observer.dart';

import 'core/di/di.dart';


void main() async {
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
  await dotenv.load(fileName: ".env");

  // WidgetsFlutterBinding.ensureInitialized();
  // await AppSharedPreferences.init();
  // await AuthSharedPreferences.init();
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => LanguageProvider(),
  //     child: const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppTheme.Theme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HomeTab.name,
      routes: {
        AppRoutes.HomeTab.name: (context) => const HomeTab(),
        AppRoutes.InitialRoute.name: (context) => const InitialRoute(),
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.BasicOnBoarding.name: (context) => const BasicOnBoarding(),
        AppRoutes.UpdateProfile.name: (context) => UpdateProfileScreen(),
        AppRoutes.LoginScreen.name: (context) => const LoginScreen(),
        AppRoutes.RegisterScreen.name: (context) => const RegisterScreen(),
      },
    );
  }
}
