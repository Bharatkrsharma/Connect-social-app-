import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectapp/presentation/auth/edit_profile.dart';
import 'package:connectapp/presentation/profile/widgets/follow_button.dart';
import 'package:connectapp/presentation/profile/widgets/profile_header_card.dart';
import 'package:connectapp/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class ProfileCard extends StatefulWidget {
//   const ProfileCard({
//     super.key,
//     required this.userData,
//     required this.userId,
//   });
//   final String userId;
//   final Map<String, dynamic> userData;
//
//   @override
//   State<ProfileCard> createState() => _ProfileCardState();
// }
//
// class _ProfileCardState extends State<ProfileCard> {
//   var userData = {};
//   int postLen = 0;
//   int follower = 0;
//   int following = 0;
//   bool isFollowing = false;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       var userSnap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.userId)
//           .get();
//
//       // get post lENGTH
//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();
//
//       postLen = postSnap.docs.length;
//       userData = userSnap.data()!;
//       follower = userSnap.data()!['follower'].length;
//       following = userSnap.data()!['following'].length;
//       isFollowing = userSnap
//           .data()!['follower']
//           .contains(FirebaseAuth.instance.currentUser!.uid);
//       setState(() {});
//     } catch (e) {
//       showSnackBar(
//         context,
//         e.toString(),
//       );
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//                             backgroundImage:
//                                 NetworkImage(widget.userData["profileUrl"]),
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
//                   widget.userData["userName"],
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
//                 ),
//                 widget.userId == FirebaseAuth.instance.currentUser!.uid
//                     ? IconButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: ((context) => EditProfile(
//                                     userDetails: widget.userData,
//                                   ))));
//                         },
//                         icon: Icon(Icons.edit))
//                     : isFollowing
//                         ? FollowButton(
//                             text:
//                                 'UnFollow', //make it unfollow refer rivan ranavat.
//                             backgroundColor: Colors.black45,
//                             textColor: Colors.white,
//                             borderColor: Colors.black26,
//                             function: () async {
//                               await FirestoreService().followUser(
//                                 FirebaseAuth.instance.currentUser!.uid,
//                                 widget.userData['userId'],
//                               );
//
//                               setState(() {
//                                 isFollowing = false;
//                                 follower--;
//                               });
//                             },
//                           )
//                         : FollowButton(
//                             text: 'Follow',
//                             backgroundColor: Colors.blue,
//                             textColor: Colors.white,
//                             borderColor: Colors.blue,
//                             function: () async {
//                               await FirestoreService().followUser(
//                                 FirebaseAuth.instance.currentUser!.uid,
//                                 widget.userData['userId'],
//                               );
//
//                               setState(() {
//                                 isFollowing = true;
//                                 follower++;
//                               });
//                             },
//                           )
//               ],
//             ),
//             Text(widget.userData["bio"]),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               widget.userData["des"],
//               style: TextStyle(color: Colors.grey.shade400),
//             ),
//             SizedBox(
//               height: 30,
//               child: TextButton(
//                   onPressed: () {}, child: Text(widget.userData["url"])),
//             )
//           ],
//         ));
//   }
// }
//
// // for displaying snackbars
// showSnackBar(BuildContext context, String text) {
//   return ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }


class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.userData,
    required this.userId,
  });
  final String userId;
  final Map<String, dynamic> userData;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  var userDetail = {};
  int postLen = 0;
  int follower = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: widget.userData['id'],)
          .get();

      postLen = postSnap.docs.length;
      userDetail = userSnap.data()!;
      follower = userSnap.data()!['follower'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['follower']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xFF1B1B1B),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Color(0xCAF15800),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(widget.userData["profileUrl"]),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 5,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Icon(Icons.add_circle_outline)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ProfileCountTitle(
                    title: 'Post',
                    count: postLen.toString(),
                  ),
                  CustomDivider(),
                  ProfileCountTitle(
                    title: 'Followers',
                    count: follower.toString(),
                  ),
                  CustomDivider(),
                  ProfileCountTitle(
                    title: 'Following',
                    count: following.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.userData["userName"],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                widget.userId == FirebaseAuth.instance.currentUser!.uid
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => EditProfile(
                                    userDetails: widget.userData,
                                  ))));
                        },
                        icon: Icon(Icons.edit))
                    : isFollowing
                        ? FollowButton(
                            text:
                                'UnFollow', //make it unfollow refer rivan ranavat.
                            backgroundColor: Colors.black45,
                            textColor: Colors.white,
                            borderColor: Colors.black26,
                            function: () async {
                              await FirestoreService().followUser(
                                FirebaseAuth.instance.currentUser!.uid,
                                widget.userData['id'],
                              );

                              setState(() {
                                isFollowing = false;
                                follower--;
                              });
                            },
                          )
                        : FollowButton(
                            text: 'Follow',
                            backgroundColor: Colors.black45,
                            textColor: Colors.white,
                            borderColor: Colors.black26,
                            function: () async {
                              await FirestoreService().followUser(
                                FirebaseAuth.instance.currentUser!.uid,
                                widget.userData['id'],
                              );

                              setState(() {
                                isFollowing = true;
                                follower++;
                              });
                            },
                          )
              ],
            ),
            Text(widget.userData["bio"]),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.userData["des"],
              style: TextStyle(color: Colors.grey.shade400),
            ),
            SizedBox(
              height: 30,
              child: TextButton(
                  onPressed: () {}, child: Text(widget.userData["url"])),
            )
          ],
        ));
  }
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
