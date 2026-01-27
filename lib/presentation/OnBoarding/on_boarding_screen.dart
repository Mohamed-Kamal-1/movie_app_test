import 'package:flutter/material.dart';
import 'package:movie_app/presentation/OnBoarding/widgets/page_view_widget.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'on_boarding_details.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                var onBoarding = OnBoardingDetails.onBoardingList[index];
                return PageViewWidget(onBoarding: onBoarding);
              },
            ),
          ),
        ],
      ),
    );
  }
}
