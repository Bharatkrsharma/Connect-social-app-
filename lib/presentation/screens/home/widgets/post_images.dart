
import 'package:flutter/material.dart';

import '../../../upload_post/widgets/video_player_card.dart';

class PostImages extends StatelessWidget {
  PostImages({super.key, required this.imageUrls});
  // final List<String> imageUrls = [
  //   'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  //   'https://images.pexels.com/photos/248747/pexels-photo-248747.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  //   'https://images.pexels.com/photos/100582/pexels-photo-100582.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  //   'https://images.pexels.com/photos/240222/pexels-photo-240222.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  // ];

  final List imageUrls;
  String checkMediaType(String url) {
    final extensionPart = url.split('.').last.toLowerCase();
    final extensionParts = extensionPart.split("?");
    final extension = extensionParts.first;
    print("extension");
    if (extension == "jpg" || extension == "jpeg" || extension == "png") {
      return "isImage";
    } else if (extension == "mp4" || extension == "avi") {
      return "isVideo";
    }
    return "others";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PageView.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            var type = checkMediaType(
              imageUrls[index],
            );
            return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: type ==
                    "isImage"
                    ? Image.network(
                  imageUrls[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : type ==
                    "isVideo"
                    ? VideoApp(url: imageUrls[index])
                    : SizedBox());
          }),
    );
  }
}
