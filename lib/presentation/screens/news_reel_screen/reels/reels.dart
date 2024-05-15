

import 'package:card_swiper/card_swiper.dart';
import 'package:connectapp/presentation/screens/news_reel_screen/reels/content_screen.dart';
import 'package:flutter/material.dart';
class Reels extends StatelessWidget {
  Reels({super.key});
  final List<String> videos = [
    'https://videos.pexels.com/video-files/20576968/20576968-hd_1920_1080_25fps.mp4',
    'https://videos.pexels.com/video-files/20770858/20770858-hd_1080_1920_30fps.mp4',
    'https://videos.pexels.com/video-files/20600550/20600550-uhd_3840_2160_30fps.mp4',
    'https://videos.pexels.com/video-files/9844511/9844511-hd_1080_1920_30fps.mp4',
    'https://videos.pexels.com/video-files/20325563/20325563-uhd_3840_2160_60fps.mp4',
    'https://videos.pexels.com/video-files/20683835/20683835-hd_1080_1920_30fps.mp4',
    'https://videos.pexels.com/video-files/3752531/3752531-hd_1920_1080_24fps.mp4',
    'https://videos.pexels.com/video-files/5991156/5991156-hd_1280_720_30fps.mp4',
    'https://videos.pexels.com/video-files/15594558/15594558-hd_1920_1080_30fps.mp4',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen(
                    src: videos[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reels',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.camera_alt),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}