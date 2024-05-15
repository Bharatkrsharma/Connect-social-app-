import 'package:connectapp/presentation/screens/home/widgets/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  StoryCard({
    super.key,
    required this.profileImage,
    required this.userName,
  });
  final String profileImage;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Story_page(
                profileImage: profileImage,
                userName: userName,
              )));
              },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(profileImage),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(userName),
        ],
      ),
    );
  }
}