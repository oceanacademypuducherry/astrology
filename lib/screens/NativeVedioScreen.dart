import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class NativeVedioUrl extends StatefulWidget {
  NativeVedioUrl({required this.vedioUrl});

  final String vedioUrl;

  @override
  _NativeVedioUrlState createState() => _NativeVedioUrlState();
}

class _NativeVedioUrlState extends State<NativeVedioUrl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video oooooPlayer"),
      ),
      body: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            widget.vedioUrl,
            betterPlayerConfiguration:
                BetterPlayerConfiguration(autoPlay: true, fit: BoxFit.fill
                    // aspectRatio: 16 / 9,
                    ),
          )),
    );
  }
}
