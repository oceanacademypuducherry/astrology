import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class NativeVedioUrl extends StatefulWidget {
  NativeVedioUrl(
      {required this.vedioUrl,
      required this.videoDescription,
      required this.videoTitle});

  final String vedioUrl;
  final String videoTitle;
  final String videoDescription;

  @override
  _NativeVedioUrlState createState() => _NativeVedioUrlState();
}

class _NativeVedioUrlState extends State<NativeVedioUrl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(
                widget.vedioUrl,
                betterPlayerConfiguration:
                    BetterPlayerConfiguration(autoPlay: true, fit: BoxFit.fill
                        // aspectRatio: 16 / 9,
                        ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('images/admin.jpg'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '${widget.videoTitle}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              '${widget.videoDescription}',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
