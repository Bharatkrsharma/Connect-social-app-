// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectapp/presentation/screens/home/widgets/story_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Story_Card_detail extends StatelessWidget {
//   Story_Card_detail({super.key});
//
//   final CollectionReference users = FirebaseFirestore.instance.collection('users');
//   var storyData = [
//     {
//       'imageUrl':
//       'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//       'userName': 'ram',
//     },
//     {
//       'imageUrl':
//       'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//       'userName': 'monu',
//     },
//     {
//       'imageUrl':
//       'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//       'userName': 'user3',
//     },
//     {
//       'imageUrl':
//       'https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//       'userName': 'user4',
//     },
//     {
//       'imageUrl':
//       'https://media.istockphoto.com/id/979622962/photo/hand-putting-wooden-cube-block-on-blue-background-with-word-career-and-copy-space-for-your.jpg?s=1024x1024&w=is&k=20&c=Upu4MQyWyA1tJFgMgV5_rIvdJt9Oz_E-reCKK_FY7AY=',
//       'userName': 'user5',
//     },
//   ];
//   // getData() async {
//   //   try {
//   //     var userSnap = await FirebaseFirestore.instance
//   //         .collection('users')
//   //         .where('userId', isEqualTo: widget.userData['id'],)
//   //         .get();
//   //
//   //
//   //
//   //   } catch (e) {
//   //    print(e);
//   //
//   //   }
//   //
//   // }
//   var userstroydetail;
//
//   @override
//   Widget build(BuildContext context) {
//     final String userId = FirebaseAuth.instance.currentUser!.uid;
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(userId).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//           userstroydetail=data['following'] ;
//           return ListView.builder(
//               itemCount: data['following'].length,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return FutureBuilder<DocumentSnapshot>(
//                     future: users.doc(userstroydetail).get(),
//                     builder: (context, snapshot){
//                       if (snapshot.connectionState == ConnectionState.done){
//                         Map<String, dynamic> storydatas = snapshot.data!.data() as Map<String, dynamic>;
//                         return StoryCard(
//                               profileImage:
//                               storydatas[index]['profileUrl']!,
//                               userName: storydatas[index]['userName']!,
//                             );
//                       }
//                     });
//
//                   // StoryCard(
//                   //   profileImage:
//                   //   storyData[index]['imageUrl']!,
//                   //   userName: userstroydetail.toString(),
//                   // );
//               });
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectapp/presentation/screens/home/widgets/story_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Story_Card_detail extends StatelessWidget {
  Story_Card_detail({super.key});

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          var followingList = data['following'] as List<dynamic>?;

          if (followingList == null || followingList.isEmpty) {
            return Center(child: Text('No following users'));
          }

          return ListView.builder(
            itemCount: followingList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FutureBuilder<DocumentSnapshot>(
                future: users.doc(followingList[index]).get(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    Map<String, dynamic> storydata = snapshot.data!.data() as Map<String, dynamic>;
                    return StoryCard(
                      profileImage: storydata['profileUrl']!,
                      userName: storydata['userName']!,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
