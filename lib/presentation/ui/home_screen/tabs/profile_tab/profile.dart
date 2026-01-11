import 'package:flutter/material.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_screen.dart';

class ProfileTab extends StatefulWidget {
  final int movieId;

  const ProfileTab({super.key, required this.movieId});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
   List<int> movies = [];
   @override
  void initState() {
    // TODO: implement initState
    movies.add(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    return UserProfileScreen();
  }
}
