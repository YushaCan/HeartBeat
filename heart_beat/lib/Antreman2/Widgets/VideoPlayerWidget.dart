import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onInitialized;
  const VideoPlayerWidget(@required this.exercise, {Key? key, required this.onInitialized}) : super(key: key);
  //VideoPlayerWidget(this.exercise,this.onInitialized);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState(){
    super.initState();
    controller = VideoPlayerController.asset(widget.exercise.videoUrl!)..initialize().then(
            (value){
              controller.setLooping(true);
              controller.play();
              widget.exercise.controller = controller;
              widget.onInitialized();
              });
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: controller.value.isInitialized
    ? VideoPlayer(controller)
    : Center(child: CircularProgressIndicator(),),
  );
}
