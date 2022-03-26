import 'package:video_player/video_player.dart';

class Exercise {
  late String? name;
  late String? duration;
  late String? noOfReps;
  late String? videoUrl;
  late String? iconUrl;
  late String? isDone;
  late String? set;
  late VideoPlayerController? controller;

  Exercise({
     this.name,
     this.duration,
     this.noOfReps,
     this.videoUrl,
     this.iconUrl,
     this.isDone,
     this.set
  });
}
