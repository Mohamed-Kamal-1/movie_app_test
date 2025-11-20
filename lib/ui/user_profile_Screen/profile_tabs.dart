import 'package:flutter/material.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: const TabBar(
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.remove_red_eye, color: Colors.yellow),
                  text: "Watch List",
                ),
                Tab(
                  icon: Icon(Icons.history, color: Colors.yellow),
                  text: "History",
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: [
                WatchListViewContainer(),

                Center(
                  child: Text(
                    "History Content Here",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WatchListViewContainer extends StatelessWidget {
  const WatchListViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(50, (i) => "item $i");

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: dummyList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return Container(margin: const EdgeInsets.all(8), color: Colors.red);
      },
    );
  }
}
