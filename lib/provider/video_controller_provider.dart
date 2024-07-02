// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoControllerProvider extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  bool _isPlaying = false;
  Timer? _hideTimer;

  bool get isPlaying => _isPlaying;

  Future<void> initializeVideo(String url) async {
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: false, // Ensure Chewie controls are hidden
      showOptions: false,
    );
    notifyListeners();
  }

  void play() {
    chewieController?.play();
    _isPlaying = true;
    _startHideTimer();
    notifyListeners();
  }

  void pause() {
    chewieController?.pause();
    _isPlaying = false;
    _startHideTimer();
    notifyListeners();
  }

  void togglePlayPause() {
    if (_isPlaying) {
      pause();
    } else {
      play();
    }
  }

  void disposeControllers() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    _hideTimer?.cancel();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      _hideTimer = null;
      notifyListeners();
    });
  }

  bool shouldShowControls() {
    return _hideTimer != null && _hideTimer!.isActive;
  }
}
