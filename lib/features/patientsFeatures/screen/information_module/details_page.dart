import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/controller/video_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:video_player/video_player.dart';

class InfoDetailsPage extends StatelessWidget {
  const InfoDetailsPage({super.key,
    required this.image,
    required this.title,
    required this.videoUrl});

   final String image;
  final String title;
  final String videoUrl;
  

  @override
  Widget build(BuildContext context) {
    // final VideoController videoController = Get.put(VideoController());
    // videoController.setVideoUrl(videoUrl); 
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_circle_left_copy),
        ),
        title: Text(
          title,
          style: KTextTheme.lightTextTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Player Section
              GetBuilder<VideoController>(
                init: VideoController(),
                builder: (controller) {
                  if (!controller.isVideoInitialized.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        AspectRatio(
                          aspectRatio:
                              controller.videoPlayerController.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(controller.videoPlayerController),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: controller.enterFullScreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                controller.videoPlayerController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: controller.togglePlayPause,
                            ),
                            IconButton(
                              icon: Icon(Icons.replay),
                              onPressed: () {
                                controller.videoPlayerController
                                    .seekTo(Duration.zero);
                                controller.videoPlayerController.play();
                              },
                            ),
                          ],
                        ),
                        VideoProgressIndicator(
                          controller.videoPlayerController,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.blueAccent,
                            bufferedColor: Colors.grey,
                            backgroundColor: Colors.black12,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              // Photo and Caption Section
              const SizedBox(height: 20),
              // Replace with your actual content for the section below the video
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Screening Recommendations',style: KTextTheme.lightTextTheme.headlineSmall,),
                  // Image.asset('assets/stats/screen1.jpg'),
                  // const SizedBox(height: 10),
                  // Text('Low Risk and Moderate Risk',style: KTextTheme.lightTextTheme.headlineSmall,),
                  // Image.asset('assets/stats/screen2.jpg'),
                  // const SizedBox(height: 10),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
