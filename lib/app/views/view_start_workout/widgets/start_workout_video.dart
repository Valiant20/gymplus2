import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:chewie_video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gymplus/core/constants/color_constants.dart';
import 'package:gymplus/data/exercise_data.dart';

class StartWorkoutVideo extends StatefulWidget {
  final ExerciseData exercise;
  final Function(int) onPlayTapped;
  final Function(int) onPauseTapped;

  const StartWorkoutVideo({super.key, 
    required this.exercise,
    required this.onPlayTapped,
    required this.onPauseTapped,
  });
  @override
  _StartWorkoutVideoState createState() => _StartWorkoutVideoState();
}

class _StartWorkoutVideoState extends State<StartWorkoutVideo> {
  late VideoPlayerController _controller;
  late bool isPlayButtonHidden = false;
  late ChewieController _chewieController;
  Timer? timer;
  Timer? videoTimer;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.exercise.video);

    _controller.initialize();

    _chewieController = ChewieController(
        videoPlayerController: _controller,
        looping: true,
        autoPlay: false,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        aspectRatio: 15 / 10,
        placeholder: const Center(child: CupertinoActivityIndicator()),
        materialProgressColors: ChewieProgressColors(playedColor: ColorConstants.primaryColor));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: _controller.value.aspectRatio, child: _createVideoContainer());
  }

  Widget _createVideoContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Theme(data: Theme.of(context).copyWith(platform: TargetPlatform.android), child: Chewie(controller: _chewieController)),
    );
  }
}