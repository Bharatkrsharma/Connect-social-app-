import 'package:flutter/material.dart';

class ProfilePostCards extends StatelessWidget {
  ProfilePostCards({super.key});

  List<Map<String, dynamic>> mediaItems = [
    {
      "id": "1",
      'imageUrl':
      'https://images.pexels.com/photos/61120/pexels-photo-61120.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isVideo': false
    },
    {
      "id": "2",
      'imageUrl':
      'https://images.pexels.com/photos/39853/woman-girl-freedom-happy-39853.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isVideo': true
    },
    {
      "id": "3",
      'imageUrl':
      'https://images.pexels.com/photos/1232594/pexels-photo-1232594.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isVideo': false
    },
    {
      "id": "4",
      'imageUrl':
      'https://images.pexels.com/photos/670720/pexels-photo-670720.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isVideo': false
    },
    {
      "id": "5",
      'imageUrl':
      'https://images.pexels.com/photos/103123/pexels-photo-103123.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isVideo': false
    },
    {
      "id": "6",
      'imageUrl':
      'https://images.pexels.com/photos/91224/pexels-photo-91224.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'isVideo': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: mediaItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemBuilder: (context, index) {
          var item = mediaItems[index];
          final bool isVideo = item['isVideo'];
          return Stack(
            children: [
              Image.network(
                "${item['imageUrl']}",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              if (isVideo)
                Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.play_circle_fill_outlined))
            ],
          );
        });
  }
}
