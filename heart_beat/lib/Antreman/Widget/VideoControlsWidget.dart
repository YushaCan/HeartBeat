import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman/Model/exercise.dart';

class VideoControlsWidget extends StatelessWidget {
  const VideoControlsWidget({Key? key, required this.exercise, required this.onRewindVideo, required this.onNextVideo, required this.onTogglePlaying}) : super(key: key);

  final Exercise exercise;
  final VoidCallback onRewindVideo;
  final VoidCallback onNextVideo;
  final ValueChanged<bool> onTogglePlaying;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white.withOpacity(0.95),
    ),
    height: 142,
    child: buildButtons(context),
  );

  Widget buildButtons(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        onPressed: onRewindVideo,
        icon: Icon(
          Icons.fast_rewind,
          color: Colors.black87,
          size: 32,
        ),),
      buildPlayButton(context),
      IconButton(onPressed: onNextVideo,
        icon: Icon(
          Icons.fast_forward,
          color: Colors.black87,
          size: 32,
        ),)
    ],
  );

  Widget buildPlayButton(BuildContext context){
    return buildButton(
      context,
      icon: Icon(Icons.play_arrow, size: 30, color: Colors.white,),
      onClicked: (){},
    );
  }

  Widget buildButton(
      BuildContext context,{
        required Widget icon,
        required VoidCallback onClicked,
      }) =>
      GestureDetector(
        onTap: onClicked,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFff6369),
            child: icon,
          ),
        ),
      );
}

