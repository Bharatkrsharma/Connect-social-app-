
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileSaveCards extends StatefulWidget {
  final String postId;
  final String userId;

  ProfileSaveCards({
    required this.postId,
    required this.userId,
  });

  @override
  State<ProfileSaveCards> createState() => _ProfileSaveCardsState();
}

class _ProfileSaveCardsState extends State<ProfileSaveCards> {
  late Stream<DocumentSnapshot> _firestore;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("saveData")
        .doc(widget.userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return const Center(
              child: Text('')
          );
        }

        // Get the document data
        final Map<String, dynamic> commentData = snapshot.data!.data()! as Map<String, dynamic>;

        // Print the snapshot data to see its structure
        print(commentData);

        // Print the snapshot data to see its structure
        // print(snapshot.data!.data());

        if (commentData.containsKey('postImages')) {
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap:true,
            itemCount: commentData['postImages'].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              //mainAxisExtent: 310,
            ),
            itemBuilder: (context, index) {
              // Get the image URL from the list
              String imageUrl = commentData['postImages'][index];
              return Stack(
                children: [
                  Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.bookmark, color: Colors.red),
                  ),
                ],
              );
            },
          );
        } else {
          return Center(child: Text('No post images available'));
        }
      },
    );
  }
}
