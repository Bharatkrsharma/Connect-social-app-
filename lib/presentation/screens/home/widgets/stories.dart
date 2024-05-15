import 'package:flutter/material.dart';
import "package:story_view/story_view.dart";

class Story_page extends StatefulWidget {
  Story_page({super.key, required this.profileImage, required this.userName});
  final String profileImage;
  final String userName;

  @override
  State<Story_page> createState() => _StoriesState();
}

class _StoriesState extends State<Story_page> {
  final controller =StoryController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        controller: controller,
          storyItems:[
            //StoryItem.text(title: widget.userName, backgroundColor: Colors.black),
            StoryItem.pageImage(url: widget.profileImage, controller: controller,
              caption: Text(
                widget.userName,
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                  fontSize: 25,
                ),
                textAlign:TextAlign.center,
              ),
            ),
          ],
        inline: false,
        repeat: false,
          onComplete: () {
          Navigator.pop(context);
          },
      ),
    );
  }
}
