
import 'package:connectapp/presentation/profile/profile_view.dart';
import 'package:connectapp/presentation/screens/home/home_view.dart';
import 'package:connectapp/presentation/screens/nav_bar.dart';
import 'package:connectapp/presentation/screens/news_reel_screen/add_screen.dart';
import 'package:connectapp/presentation/search/search_view.dart';
import 'package:connectapp/presentation/upload_post/post_view.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BodyView extends StatefulWidget {
  const BodyView({super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  int currentIndex = 0;
  var pageViewList = [
    HomeView(),
    SearchView(),
    PostView(),
    AddScreen(),
    ProfileView(
      userId: FirebaseAuth.instance.currentUser!.uid,
      //postId:FirebaseFirestore.instance.collection('posts').doc().get();
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text("Tag again to exit !"),
      ),
      child: Scaffold(
        bottomNavigationBar: NavBar(
          onDestinationSelected: (int value) {
            setState(() {
              currentIndex = value;
            });
          },
          selectedIndex: currentIndex,
        ),
        body: pageViewList[currentIndex],
      ),
    );
  }
}
