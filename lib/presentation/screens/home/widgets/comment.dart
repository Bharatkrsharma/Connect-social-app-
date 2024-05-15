
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectapp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  String postId;

  // String userId;
  Comment(
      this.postId,
      //this.userId,
      //this.postData,
          {super.key, required this.postData});

  final dynamic postData;
  @override
  State<Comment> createState() => _CommentState();
}
CollectionReference post = FirebaseFirestore.instance.collection('posts');
final fireStore = FirebaseFirestore.instance.collection('posts').snapshots();
CollectionReference users = FirebaseFirestore.instance.collection('users');
CollectionReference posts = FirebaseFirestore.instance.collection('posts');


class _CommentState extends State<Comment> {
  FirestoreService firestoreService = FirestoreService();
  final comment = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> postsData = [];
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        color: Colors.black87,
        height: 180,
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 135,
              child: Container(
                width: 100,
                height: 3,
                color: Colors.white,
              ),
            ),
            // StreamBuilder<QuerySnapshot>(
            //     stream: _firestore
            //         .collection('posts')
            //         .doc(
            //         //post.doc().id
            //         widget.postId
            //     )
            //         .collection('comments')
            //         .snapshots(),
            //     builder: (context, snapshot) {
            //       return ListView.builder(
            //         itemBuilder: (context, index) {
            //           if (!snapshot.hasData) {
            //             return CircularProgressIndicator();
            //           }var cummentdata = snapshot.data!.docs[index].data();
            //           return comment_item(cummentdata);
            //         },
            //         itemCount:
            //             snapshot.data == null ? 0 : snapshot.data!.docs.length,
            //       );
            //     }),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Text('No data available');
                }

                // Print the snapshot data to see its structure
                print(snapshot.data!.docs);

                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20,),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var commentData = snapshot.data!.docs[index].data();

                      // Use the commentData to build your comment item
                      return
                        comment_item(commentData);
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                );
              },
            ),

            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 260,
                      child: TextField(
                        controller: comment,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText:
                          'Add a Comment',
                          fillColor: Colors.black87,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {//&& widget.postId != null
                        print(widget.postId);
                        if(comment.text.isNotEmpty){
                          firestoreService.addComment(comment.text,widget.postId,
                            //widget.postData['id'],
                          );
                        }
                        setState(() {
                          comment.clear();
                        });
                      },
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comment_item(final snapshot) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          height: 35,
          width: 35,
          child: Image.network(snapshot['profileUrl'],
            //which path should i add here

          ),
        ),
      ),
      title: Text(snapshot['username'],
        //which path should i add here
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(snapshot['comment'],
        //which path should i add here
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}
