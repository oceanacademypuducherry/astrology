import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  String vedioLink;
  String vedioName;
  String vedioDescription;
  YoutubeScreen(
      {required this.vedioLink,
      required this.vedioDescription,
      required this.vedioName});
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late YoutubePlayerController mYoutubePlayerController;

  @override
  void initState() {
    super.initState();
    mYoutubePlayerController = YoutubePlayerController(
        initialVideoId: '${YoutubePlayer.convertUrlToId(widget.vedioLink)}',
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: mYoutubePlayerController),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Free Video",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                child: player,
              ),
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
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text(
                        '${widget.vedioName}',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  '${widget.vedioDescription}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
