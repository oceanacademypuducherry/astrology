// // import 'dart:async';
// //
// // import 'package:astrology_app/screens/vedioPlayer/custom_control_buttons.dart';
// // import 'package:astrology_app/screens/vedioPlayer/overlayWidget.dart';
// // import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';
// //
// class VideoPlayerBothWidget extends StatefulWidget {
//   final VideoPlayerController controller;
//
//   const VideoPlayerBothWidget({
//     required this.controller,
//   });
//
//   @override
//   _VideoPlayerBothWidgetState createState() => _VideoPlayerBothWidgetState();
// }
//
// class _VideoPlayerBothWidgetState extends State<VideoPlayerBothWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) => widget.controller != null && widget.controller.value.isInitialized
//       ? Container(alignment: Alignment.topCenter, child: buildVideo())
//       : Center(child: CircularProgressIndicator());
//
//   Widget buildVideo() => OrientationBuilder(
//         builder: (context, orientation) {
//           final isPortrait = orientation == Orientation.portrait;
//
//           // setOrientation(isPortrait);
//
//           return Column(
//             children: [
//               Stack(
//                 fit: isPortrait ? StackFit.loose : StackFit.expand,
//                 children: <Widget>[
//                   buildVideoPlayer(),
//                   Positioned.fill(
//                     child: AdvancedOverlayWidget(
//                       controller: widget.controller,
//                       onClickedFullScreen: () {
//                         if (isPortrait) {
//                           AutoOrientation.landscapeRightMode();
//                         } else {
//                           AutoOrientation.portraitUpMode();
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               CustomControlsWidget(controller: widget.controller)
//             ],
//           );
//         },
//       );
//
//   Widget buildVideoPlayer() {
//     final video = AspectRatio(
//       aspectRatio: widget.controller.value.aspectRatio,
//       child: VideoPlayer(widget.controller),
//     );
//
//     return buildFullScreen(child: video);
//   }
//
//   Widget buildFullScreen({
//     required Widget child,
//   }) {
//     final size = widget.controller.value.size;
//     final width = size.width;
//     final height = size.height;
//
//     return FittedBox(
//       fit: BoxFit.cover,
//       child: SizedBox(width: width, height: height, child: child),
//     );
//   }
// }
