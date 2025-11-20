import 'package:flutter/material.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile.dart';

import '../../core/images/app_image.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        AppImage.midImage,
                        width: 118,
                        height: 118,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Mohamed"),
                  ],
                ),

                Column(
                  children: [
                    Text("12"),
                    SizedBox(height: 20),
                    Text("Wish List"),
                  ],
                ),
                Column(
                  children: [Text("10"), SizedBox(height: 20), Text("History")],
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateProfile();
                        },
                      ),
                    );
                  },
                  child: Text("Edit profile"),
                ),
                SizedBox(width: 20),
                ElevatedButton(onPressed: () {}, child: Text("Exit")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
