
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectapp/presentation/screens/home/widgets/post_view.dart';
import 'package:connectapp/presentation/screens/home/widgets/profile_story_card.dart';
import 'package:connectapp/presentation/screens/home/widgets/story_card.dart';
import 'package:connectapp/presentation/screens/home/widgets/story_card_details.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({
    super.key,
  });

  var storyData = [
    {
      'imageUrl':
      'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'ram',
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'monu',
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'user3',
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'user4',
    },
    {
      'imageUrl':
      'https://media.istockphoto.com/id/979622962/photo/hand-putting-wooden-cube-block-on-blue-background-with-word-career-and-copy-space-for-your.jpg?s=1024x1024&w=is&k=20&c=Upu4MQyWyA1tJFgMgV5_rIvdJt9Oz_E-reCKK_FY7AY=',
      'userName': 'user5',
    },
  ];

  var postData = [
    {
      'imageUrl':
      'https://images.pexels.com/photos/670720/pexels-photo-670720.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'Bharat Kumar Sharma',
      'profileImage':
      "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/598917/pexels-photo-598917.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'paresh',
      'profileImage':
      'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/447329/pexels-photo-447329.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'Akansha',
      'profileImage':
      'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'Akansha',
      'profileImage':
      'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'imageUrl':
      'https://images.pexels.com/photos/333850/pexels-photo-333850.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'userName': 'Akansha',
      'profileImage':
      'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
  ];

  var likeImagesList = [
    'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              expandedHeight: 40,
              floating: true,
              pinned: false,
              snap: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Connect",
                        style: TextStyle(fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.radio_button_unchecked_sharp,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.message_rounded),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 125,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProfileStoryCard(),
                    Story_Card_detail(),

                    // ListView.builder(
                    //     itemCount: storyData.length,
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemBuilder: (context, index) {
                    //       return
                    //         StoryCard(
                    //         profileImage: storyData[index]['imageUrl']!,
                    //         userName: storyData[index]['userName']!,
                    //       );
                    //     }),
                    //StoryCard(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: PostsView(postData: postData, likeImagesList: likeImagesList),
            ),
          ],
        ),
      ),
    );
  }
}

