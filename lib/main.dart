import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/presentation/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/presentation/OnBoarding/on_boarding_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/profile_tab/profile.dart';
import 'package:movie_app/ui/Register/register.dart';
import 'package:movie_app/ui/details_screen/details_screen.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile_screen.dart';
import 'package:movie_app/ui/forget_password_screen/forget_screen.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_screen.dart';
import 'package:movie_app/ui/login_screen/login_screen.dart';
import 'api/my_bloc_observer.dart';
import 'bloc/language_provider.dart';
import 'package:provider/provider.dart';
import 'core/di/di.dart';
import 'package:movie_app/SharedPreferences/language_shared_preferences.dart';
import 'package:movie_app/SharedPreferences/auth_shared_preferences.dart';



void main() async {
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  await AuthSharedPreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppTheme.Theme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const _InitialRoute(),
      //initialRoute: AppRoutes.OnBoardingScreen.name,
      routes: {
        AppRoutes.HomeTab.name: (context) => const HomeTab(),
        AppRoutes.ProfileTab.name: (context) => ProfileTab(),
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.BasicOnBoarding.name: (context) => const BasicOnBoarding(),
        AppRoutes.UpdateProfile.name: (context) => UpdateProfileScreen(),
        AppRoutes.UserProfileScreen.name: (context) => UserProfileScreen(),
        AppRoutes.LoginScreen.name: (context) => const LoginScreen(),
        AppRoutes.ForgetScreen.name: (context) => const ForgetScreen(),
        AppRoutes.RegisterScreen.name: (context) => const RegisterScreen(),
        AppRoutes.DetailsScreen.name: (context) => const DetailsScreen(),
      },
    );
  }
}

class _InitialRoute extends StatefulWidget {
  const _InitialRoute();

  @override
  State<_InitialRoute> createState() => _InitialRouteState();
}

class _InitialRouteState extends State<_InitialRoute> {
  @override
  void initState() {
    super.initState();
    _determineInitialRoute();
  }

  Future<void> _determineInitialRoute() async {
    // Check if it's the first time
    final isFirstTime = await AuthSharedPreferences.isFirstTime();
    
    // Check if user has a token
    final token = AuthSharedPreferences.getToken();
    
    if (!mounted) return;
    
    // Routing logic:
    // 1. If first time → OnBoardingScreen
    // 2. If NOT first time AND token is null → LoginScreen
    // 3. If token is NOT null → HomeTab
    if (isFirstTime) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.OnBoardingScreen.name,
      );
    } else if (token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.LoginScreen.name,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.HomeTab.name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // loading
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
