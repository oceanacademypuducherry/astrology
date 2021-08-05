import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:better_player/better_player.dart';
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
  YoutubeScreen({required this.vedioLink});
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
          body: Container(
            child: player,
          ),
        );
      },
    );
  }
}
