import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeScreen extends StatefulWidget {
//   @override
//   YoutubeScreenState createState() => YoutubeScreenState();
// }
//
// class YoutubeScreenState extends State<YoutubeScreen> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: null,
//       body: StreamBuilder(
//           stream: _firestore.collection('youtubeVedios').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//
//             return ListView(
//               children: snapshot.data!.docs.map((document) {
//                 var url = document['vedioUrl'];
//
//                 YoutubePlayerController _controller = YoutubePlayerController(
//                   initialVideoId: '${YoutubePlayer.convertUrlToId(url)}',
//                   flags: YoutubePlayerFlags(
//                     autoPlay: true,
//                     mute: false,
//
//                     // disableDragSeek: false,
//                     // loop: false,
//                     // isLive: false,
//                     // forceHD: false,
//                   ),
//                 );
//
//                 return Center(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width / 1.2,
//                     child: Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: 20,
//                             bottom: 5,
//                           ),
//                           child: Text(
//                             document['title'],
//                           ),
//                         ),
//                         AspectRatio(
//                           aspectRatio: 16 / 9,
//                           child: YoutubePlayerBuilder(
//                             player: YoutubePlayer(controller: _controller),
//                             builder: (context, player) {
//                               return Container(
//                                 child: player,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             );
//           }),
//     );
//   }
// }

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
            title: Text("Youtube Video Player"),
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
                          fontSize: 18,
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
