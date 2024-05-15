
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectapp/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatefulWidget {
  PostHeader({
    super.key,
    required this.postData,
  });
  final dynamic postData;
  @override
  State<PostHeader> createState() => _PostHeaderState();
}
Future<void> deletePost(String postId) async {
  try {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    print('Post with ID $postId deleted successfully');
  } catch (e) {
    print('Error deleting post with ID $postId: $e');
  }
}

class _PostHeaderState extends State<PostHeader> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.postData['userId'])
          .get(),
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      data['profileUrl'],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['userName'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        getTimeAgo(widget.postData['createAt'] ?? 0),
                        style: TextStyle(color: Colors.white38),
                      ),
                    ],
                  ),
                ],
              ),
              widget.postData['userId'].toString() ==
                  FirebaseAuth.instance.currentUser!.uid
              // widget.snap['uid'].toString() == users.uid
                  ? IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding:
                            const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete'
                            ]
                                .map(
                                  (e) => InkWell(
                                  child: Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16),
                                    child: Text(e),
                                  ),
                                  onTap: () {
                                    //add code for deleting post.
                                    deletePost(widget.postData['id'].toString());
                                    Navigator.of(context).pop();
                                  }),
                            )
                                .toList()),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              )
                  : IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding:
                            const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Follow',
                            ]
                                .map(
                                  (e) => InkWell(
                                  child: Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16),
                                    child: Text(e),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  }),
                            )
                                .toList()),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}

