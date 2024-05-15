
import 'package:connectapp/presentation/screens/home/widgets/comment.dart';
import 'package:connectapp/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostFooter extends StatefulWidget {
  const PostFooter({
    super.key,
    required this.likeImagesList,
    required this.postData,
  });
  final dynamic postData;
  final List<String> likeImagesList;

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  var isLike = false;
  var isSave = false;
  var likeCount = 0;
  var saveCount = 0;
  var uuid = Uuid();
  var firestoreService = FirestoreService();

  void initState() {
    super.initState();
    checkIsLike();
    checkIsSave();
    likeCount = widget.postData['likesCount'] ?? 0;
    saveCount = widget.postData['saveCount'] ?? 0;
  }

  checkIsSave() async {
    bool exits = await firestoreService.checkSaveDocumentExits(
        widget.postData['id'], FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isSave = exits;
    });
  }

  save() {
    setState(() {
      isSave = !isSave;
      if (isSave) {
        saveCount++;
      } else {
        saveCount--;
      }
      firestoreService.addSaveData(isSave, widget.postData['id'],
          FirebaseAuth.instance.currentUser!.uid);
    });
  }
  checkIsLike() async {
    bool exits = await firestoreService.checkDocumentExits(
        widget.postData['id'], FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isLike = exits;
    });
  }

  like() {
    setState(() {
      isLike = !isLike;
      if (isLike) {
        likeCount++;
      } else {
        likeCount--;
      }
      firestoreService.isLike(isLike, widget.postData['id'],
          FirebaseAuth.instance.currentUser!.uid);
    });
  }

  // addcomment() async {
  //   var id = uuid.v4();
  //   var commentData = {
  //     "id": id,
  //     "userId": FirebaseAuth.instance.currentUser!.uid,
  //     'comment': "comment",
  //     'username': widget.postData['userName'],
  //     "commentsCount": 0,
  //     "profileUrl":
  //         "https://img.freepik.com/free-vector/hand-drawn-korean-drawing-style-character-illustration_23-2149623257.jpg?size=338&ext=jpg&ga=GA1.2.647470437.1685963067&semt=robertav1_2_sidr",
  //     'timestamp': DateTime.now().millisecond,
  //   };
  //   await firestoreService.addComment(widget.postData['id'],
  //       FirebaseAuth.instance.currentUser!.uid,commentData);
  // }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> postsData = [];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // LikesImages(
                //   likeImages: widget.likeImagesList,
                // ), //remove tis LikeImage
                SizedBox(
                  width: 15,
                ),
                Text(
                  "$likeCount Likes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      like();
                    },
                    icon: isLike
                        ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                        : Icon(Icons.favorite_border_outlined)),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {
                    showBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: DraggableScrollableSheet(
                            maxChildSize: 0.6,
                            initialChildSize: 0.6,
                            minChildSize: 0.2,
                            builder: (context, scrollController) {
                              return Comment(
                                widget.postData['id'],
                                postData: postsData,
                              );
                              // Comment(widget.postData['id'],'posts', postsData: postData)
                              // check it
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.message_outlined),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  save();
                },
                icon: isSave
                    ? Icon(
                  Icons.bookmark,
                  color: Colors.red,
                )
                    : Icon(Icons.bookmark_border_outlined)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            showBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: DraggableScrollableSheet(
                    maxChildSize: 0.6,
                    initialChildSize: 0.6,
                    minChildSize: 0.2,
                    builder: (context, scrollController) {
                      return Comment(
                        widget.postData['id'],
                        postData: postsData,
                      );
                      // Comment(widget.postData['id'],'posts', postsData: postData)
                      // check it
                    },
                  ),
                );
              },
            );
          },
          child: Text(
            // widget.postData['id'],
            "View All comments",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}
