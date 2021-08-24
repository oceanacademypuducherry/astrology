// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
//
// const appId = '30d624fae8174ce098b6cd05fd5c4c3a';
// const tokenId =
//     '00630d624fae8174ce098b6cd05fd5c4c3aIABshE3br1SWNSL79825ny4ViwmdZRJuikU4ZUxRPBXjNrYNtAEAAAAAEADVf7iLvNUUYQEAAQC81RRh';
//
// class AgoraVedio extends StatefulWidget {
//   @override
//   _AgoraVedioState createState() => _AgoraVedioState();
// }
//
// class _AgoraVedioState extends State<AgoraVedio> {
//   int? _remoteUid;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//
//     //create the engine
//     _engine = await RtcEngine.create("30d624fae8174ce098b6cd05fd5c4c3a");
//     await _engine.enableVideo();
//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//           print("local user $uid joined");
//         },
//         userJoined: (int uid, int elapsed) {
//           print("remote user $uid joined");
//           setState(() {
//             _remoteUid = uid;
//           });
//         },
//         userOffline: (int uid, UserOfflineReason reason) {
//           print("remote user $uid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//
//     await _engine.joinChannel(tokenId, "ocaenacademy", null, 0);
//   }
//
//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: RtcLocalView.SurfaceView(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return RtcRemoteView.SurfaceView(uid: _remoteUid!);
//     } else {
//       return Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }
