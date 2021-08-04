import 'package:astrology_app/screens/vedioPlayer/VedioPlayer_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VedioPlayer extends StatefulWidget {
  @override
  _VedioPlayerState createState() => _VedioPlayerState();
}

class _VedioPlayerState extends State<VedioPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/astrology-7cec1.appspot.com/o/videoplayback%20(1).mp4?alt=media&token=bfb472e0-f1cd-43c4-a366-9c32eea124db')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Scaffold(
      body: Column(
        children: [
          VideoPlayerWidget(controller: controller),
          SizedBox(
            height: 30,
          ),
          if (controller != null && controller.value.isInitialized)
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.redAccent,
              child: IconButton(
                icon: Icon(isMuted ? Icons.volume_mute : Icons.volume_up),
                onPressed: () {
                  controller.setVolume(isMuted ? 1 : 0);
                },
              ),
            )
        ],
      ),
    );
  }
}
