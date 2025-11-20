import 'package:flutter/material.dart';
import 'package:movie_app/ui/user_profile_Screen/profile_tabs.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_header.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.grey,
                  pinned: false,
                  floating: true,
                  snap: true,
                  expandedHeight: 260,
                  flexibleSpace: FlexibleSpaceBar(background: ProfileHeader()),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                    child: PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: Container(
                        color: Colors.yellow,
                        child: const TabBar(
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              icon: Icon(Icons.remove_red_eye),
                              text: "Watch List",
                            ),
                            Tab(icon: Icon(Icons.history), text: "History"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },

            body: const TabBarView(
              children: [
                WatchListViewContainer(),
                Center(
                  child: Text(
                    "History Content Here",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _TabBarDelegate({required this.child});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}
