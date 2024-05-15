
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileStoryCard extends StatelessWidget {
  ProfileStoryCard({
    Key? key,
  }) : super(key: key);

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          String profileUrl = data['profileUrl'] ?? "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

          return Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(profileUrl),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 18,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         border: Border.all(width: 2.0, color: Colors.white)),
              //     child: Icon(
              //       Icons.add_circle,
              //       size: 30,
              //       color: Colors.orange,
              //     ),
              //   ),
              // ),  //make it on  after major project review.
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfileStoryCard extends StatelessWidget {
//    ProfileStoryCard({
//     super.key,
//   });
//    CollectionReference users = FirebaseFirestore.instance.collection('users');
//   @override
//   Widget build(BuildContext context) {
//     final String userId= FirebaseAuth.instance.currentUser!.uid;
//
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(width: 2, color: Colors.grey)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: CircleAvatar(
//                     radius: 35,
//                     backgroundImage: NetworkImage(
//
//                         "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 18,
//           child: Container(
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(width: 2.0, color: Colors.white)),
//             child: Icon(
//               Icons.add_circle,
//               size: 30,
//               color: Colors.orange,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
