import 'package:flutter/material.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/profile_tab/search_tab.dart';

import '../../../../../core/di/di.dart';
import '../../cubit/home_screen_view_model.dart';
import '../search_tab/search_tab.dart';
import 'bottom_navigation_section.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeScreenViewModel viewModel;
  List<Widget> tabs = [HomeTab(), SearchTab(), ProfileTab()];
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeScreenViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigationSection(
        onSelectedIndex: (index) {
          selectIndex = index;
        },
      ),
      body: HomeScreen(viewModel: viewModel),
    );
  }
}
