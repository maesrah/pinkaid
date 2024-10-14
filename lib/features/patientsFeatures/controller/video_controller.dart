import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  var isFullScreen = false.obs;
  var isVideoInitialized = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    videoPlayerController = VideoPlayerController.asset('assets/video/video1.mp4')..initialize().then((_){
      isVideoInitialized.value = true;
      videoPlayerController.play();
      update();
    });
    // videoPlayerController = VideoPlayerController.networkUrl(
    //   Uri.parse('https://youtu.be/srDdIbFLbJY'),
    // )
    //   ..initialize().then((_) {
    //     isVideoInitialized.value = true;
    //     update();
    //   });
  }

  @override
  void onClose(){
    super.onClose();
    videoPlayerController.dispose();
  }

 

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
     
    } else {
      videoPlayerController.play();
      
    }
    update();
  }

  void enterFullScreen(){
     isFullScreen.value = !isFullScreen.value;
    if (isFullScreen.value) {
      // Enter fullscreen mode and set landscape orientation
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      // Exit fullscreen mode and restore portrait orientation
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
    update();
    
  }

   
   
    
  

  
}
