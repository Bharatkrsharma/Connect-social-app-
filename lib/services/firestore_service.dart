
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  CollectionReference likes = FirebaseFirestore.instance.collection('likes');

  //final fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  Future<List<Map<String, dynamic>>> getPost() async {
    //data types
    List<Map<String, dynamic>> postData = [];
    try {
      await post.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          postData.add(doc.data() as Map<String, dynamic>);
        });
      });
      return postData;
    } catch (e) {
      return [];
    }
  }

  Future<bool> checkDocumentExits(postId, userId) async {
    try {
      DocumentSnapshot snapshot =
      await post.doc(postId).collection("likes").doc(userId).get();
      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }

  isLike(value, postId, userId) async {
    if (value) {
      var data = {
        "likeAt": DateTime.timestamp(),
        "postId": postId,
        "userId": userId,
      };
      await post.doc(postId).collection("likes").doc(userId).set(data);
      await post.doc(postId).update({"likesCount": FieldValue.increment(1)});
    } else {
      await post.doc(postId).collection("likes").doc(userId).delete();
      await post.doc(postId).update({"likesCount": FieldValue.increment(-1)});
    }
  }

  Future<void> addUser(data) async {
    try {
      await users.doc(data['id']).set(data);
    } catch (error) {
      print("Failed to add user: $error");
      throw error;
    }
  }

  Future<void> addPost(data) async {
    try {
      await post.doc(data['id']).set(data);
    } catch (error) {
      print("Failed to add user: $error");
      throw error;
    }
  }

  Future<String> uploadFile(File selectedFile) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('files')
        .child(selectedFile.path.split('/').last);

    try {
      var uploadTask = await ref.putFile(selectedFile);
      var downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw e;
    }
  }



  Future<void> updateUser(data, context) async {
    try {
      await users.doc(data['id']).update(data);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Accout Updated")));
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("updation Failed"),
              content: Text(error.toString()),
            );
          });
      throw error;
    }
  }


  Future<bool> addComment(String comment, String postId) async {
    try {
      // Get current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the users collection
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

      // Get the user document using the current user's ID
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      // Extract username and profileUrl from the user document
      String username = userSnapshot.get('userName');
      String profileUrl = userSnapshot.get('profileUrl');

      // Generate a unique ID for the comment
      var uid = Uuid().v4();

      // Add the comment to the comments collection under the specified post
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add({
        "id": uid,
        "userId": userId,
        'comment': comment,
        'username': username,
        "profileUrl": profileUrl,
        "commentsCount": 0,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });

      print('Comment added successfully');
      return true;
    } catch (e) {
      print('Error adding comment: $e');
      return false;
    }
  }

  addSaveData(value, postId, userId) async {
    try {
      // Get current user ID
      //String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the users collection
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('posts');

      // Get the user document using the current user's ID
      DocumentSnapshot userSnapshot = await usersCollection.doc(postId).get();

      // Extract username and profileUrl from the user document
      List<dynamic> postImages = userSnapshot.get('postImages');
      String description = userSnapshot.get('description');

      // Generate a unique ID for the comment
      var uid = Uuid().v4();
      if (value) {
        // Add the comment to the comments collection under the specified post
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('saveData')
            .doc(userId)
            .set({
          "id": uid,
          "saveAt": DateTime.timestamp(),
          "postId": postId,
          "userId": userId,
          "postImages": postImages,
          "description": description,
        });
        await post.doc(postId).update({"saveCount": FieldValue.increment(1)});
        // dynamic addsavecount =FirebaseFirestore.instance.collection('posts').doc(postId);
        // addsavecount.doc(postId).update({'saveCount': FieldValue.increment(1)});

        print('Saved successfully');
      } else {
        await post.doc(postId).collection("saveData").doc(userId).delete();
        await post.doc(postId).update({"saveCount": FieldValue.increment(-1)});
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  Future<bool> checkSaveDocumentExits(postId, userId) async {
    try {
      DocumentSnapshot snapshot =
      await post.doc(postId).collection("saveData").doc(userId).get();
      return snapshot.exists;
    } catch (e) {
      print("does not exist");
      return false;
    }
  }


  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await firestore.collection('users').doc(followId).update({
          'follower': FieldValue.arrayRemove([uid])
        });

        await firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await firestore.collection('users').doc(followId).update({
          'follower': FieldValue.arrayUnion([uid])
        });

        await firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
