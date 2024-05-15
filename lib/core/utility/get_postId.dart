// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<String> getPostId() async {
//   try {
//     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('posts').get();
//     if (snapshot.docs.isNotEmpty) {
//       // Assuming postId is stored in a field named 'postId' in the first document
//       return snapshot.docs.first.get('postId');
//     } else {
//       return ''; // Return an empty string if no documents are found
//     }
//   } catch (e) {
//     print('Error fetching postId: $e');
//     return ''; // Return an empty string in case of an error
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<String> getPostId() async {
//   try {
//     // Get the 'posts' collection
//     QuerySnapshot<Map<String, dynamic>> postsSnapshot =
//     await FirebaseFirestore.instance.collection('posts').get();
//
//     // Check if there are any documents in the 'posts' collection
//     if (postsSnapshot.docs.isNotEmpty) {
//       // Assuming postId is stored as a field in the document
//       String postId = postsSnapshot.docs.first.id;//here inplace of first  what else we can use for accessing all data
//
//       // Return the postId
//       return postId;
//     } else {
//       // Return an empty string if no documents are found in the 'posts' collection
//       return '';
//     }
//   } catch (e) {
//     print('Error fetching postId: $e');
//     return ''; // Return an empty string in case of an error
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getPostIds() async {
  List<String> postIds = [];

  try {
    // Get the 'posts' collection
    QuerySnapshot<Map<String, dynamic>> postsSnapshot =
    await FirebaseFirestore.instance.collection('posts').get();

    // Iterate through the documents in the 'posts' collection
    postsSnapshot.docs.forEach((doc) {
      // Assuming postId is stored as a field named 'postId' in each document
      String postId = doc.id;
      // Add the postId to the list
      postIds.add(postId);
    });

    // Return the list of postIds
    return postIds;
  } catch (e) {
    print('Error fetching postIds: $e');
    // Return an empty list in case of an error
    return [];
  }
}
