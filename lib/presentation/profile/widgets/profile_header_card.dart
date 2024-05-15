
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectapp/presentation/auth/edit_profile.dart';
import 'package:connectapp/presentation/profile/widgets/follow_button.dart';
import 'package:connectapp/presentation/profile/widgets/profile_card.dart';
import 'package:connectapp/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileHeaderCard extends StatelessWidget {
  ProfileHeaderCard({
    super.key,
    required this.userId,//remove it if not work.
  });

  final String userId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  @override
  /*Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(

          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFF181818),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 3,
                              color: Color(0xCAF15800),
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage("https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 5,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add_circle_outline)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ProfileCountTitle(
                    count: '25',
                    title: 'Post',
                  ),
                  CustomDivider(),
                  ProfileCountTitle(
                    count: '250k',
                    title: 'Followers',
                  ),
                  CustomDivider(),
                  ProfileCountTitle(
                    count: '250',
                    title: 'Following',
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("Bharat ", style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              ),
              Text("Graphic Designer | Photographer"),
              SizedBox(height: 5,),
              Text("Capturing moments, one frame at a time. ",
                style: TextStyle(color: Colors.grey.shade400),
              ),
              Text("Passinate photographer seeking beauty in every click. ",
                style: TextStyle(color: Colors.grey.shade400),
              ),
              SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: (){},
                      child: Text("https://fonts.google.com/icon")
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }*/
  Widget build(BuildContext context){
    return SliverToBoxAdapter(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(userId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
              print(data);
              return ProfileCard(
                userId: userId,
                userData: data,
              );
            }

            return Text("loading");
          },
        )
    );
  }
}
//
// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     super.key,
//     required this.userData, required this.userId,
//   });
//   final String userId;
//   final Map<String, dynamic> userData;
//
//   @override
//   Widget build(BuildContext context) {
//     int followers = 0;
//     int following = 0;
//     bool isFollowing = false;
//     bool isLoading = false;
//     return Container(
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//             color: Color(0xFF1B1B1B),
//             borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(40),
//                 bottomLeft: Radius.circular(40))),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FittedBox(
//               fit: BoxFit.cover,
//               child: Row(
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               width: 4,
//                               color: Color(0xCAF15800),
//                             )),
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: CircleAvatar(
//                             radius: 45,
//                             backgroundImage: NetworkImage(userData["profileUrl"]),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 10,
//                         right: 5,
//                         child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.red, shape: BoxShape.circle),
//                             child: Icon(Icons.add_circle_outline)),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   ProfileCountTitle(
//                     title: 'Post',
//                     count: '25',
//                   ),
//                   CustomDivider(),
//                   ProfileCountTitle(
//                     title: 'Followers',
//                     count: '250K',
//                   ),
//                   CustomDivider(),
//                   ProfileCountTitle(
//                     title: 'Following',
//                     count: '250',
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   userData["userName"],
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
//                 ),
//                 userId== FirebaseAuth.instance.currentUser!.uid ?
//                 IconButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: ((context) => EditProfile(
//                             userDetails: userData,
//                           ))));
//                     },
//                     icon: Icon(Icons.edit)):
//                 isFollowing ? FollowButton(
//                   text: 'UnFollow',//make it unfollow refer rivan ranavat.
//                   backgroundColor: Colors.black45,
//                   textColor: Colors.white,
//                   borderColor: Colors.black26,
//                   function: () async {
//                     await FirestoreService()
//                         .followUser(
//                       FirebaseAuth.instance
//                           .currentUser!.uid,
//                       userData['userId'],
//                     );
//
//                     setState(() {
//                       isFollowing = false;
//                       followers--;
//                     });
//                   },
//                 )
//                     : FollowButton(
//                   text: 'Follow',
//                   backgroundColor: Colors.blue,
//                   textColor: Colors.white,
//                   borderColor: Colors.blue,
//                   function: () async {
//                     await FirestoreService()
//                         .followUser(
//                       FirebaseAuth.instance
//                           .currentUser!.uid,
//                       userData['userId'],
//                     );
//
//                     setState(() {
//                       isFollowing = true;
//                       followers++;
//                     });
//                   },
//                 )
//
//
//               ],
//             ),
//             Text(userData["bio"]),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               userData["des"],
//               style: TextStyle(color: Colors.grey.shade400),
//             ),
//             SizedBox(
//               height: 30,
//               child: TextButton(onPressed: () {}, child: Text(userData["url"])),
//             )
//           ],
//         ));
//   }
// }



class ProfileCountTitle extends StatelessWidget {
  const ProfileCountTitle({
    super.key, required this.count, required this.title,
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        ),
        Text(title, style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(left: 15,right: 15, ),
      decoration: BoxDecoration(
        border: Border(
            right: BorderSide(
              color: Colors.grey.shade600,
              width: 2.0,
            )
        ),
      ),
    );
  }
}

