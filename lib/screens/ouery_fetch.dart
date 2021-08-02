// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// // void main() {
// //   runApp(MaterialApp(home: Scaffold(body: Query())));
// // }
//
// FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// class Query extends StatefulWidget {
//   @override
//   _QueryState createState() => _QueryState();
// }
//
// class _QueryState extends State<Query> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         StreamBuilder<QuerySnapshot>(
//           stream: _firestore.collection('queries').snapshots(),
//           // ignore: missing_return
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Text("Loading...");
//             } else {
//               final messages = snapshot.data!.docs;
//               List<Dbquery> courseDetails = [];
//               String messageContent;
//               String messageQuestion;
//               //List<String> subjects = [];
//               for (var message in messages) {
//                 List<Widget> questionList = [];
//                 List<Widget> answerList = [];
//
//                 for (var i = 0; i < message["query"].length; i++) {
//                   // if ((answerList == null)) {
//                   //   return Container(
//                   //     height: 700,
//                   //     width: 500,
//                   //     color: Colors.pinkAccent,
//                   //   );
//                   // }
//                   if (message['query'].length != null) {
//                     messageContent = message["query"][i]['answer'];
//                     messageQuestion = message["query"][i]['question'];
//                     print('++++++++++++++++++');
//                     print(messageContent);
//                     print(messageQuestion);
//                     answerList.add(
//                       Container(
//                         color: Colors.grey[100],
//                         padding: EdgeInsets.all(5.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 messageContent,
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                     questionList.add(Text(messageQuestion));
//                   }
//                 }
//                 print(answerList);
//
//                 print('%%%%%%%%%%%%%%%');
//                 // for (var i = 0; i < message["query"].length; i++) {
//                 //   if ((questionList == null)) {
//                 //     return Container(
//                 //       height: 700,
//                 //       width: 500,
//                 //       color: Colors.pinkAccent,
//                 //     );
//                 //   } else {
//                 //     messageContent = message["query"][i]['question'];
//                 //     questionList.add(
//                 //       Container(
//                 //         color: Colors.grey[100],
//                 //         padding: EdgeInsets.all(5.0),
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.stretch,
//                 //           children: [
//                 //             Padding(
//                 //               padding: const EdgeInsets.all(8.0),
//                 //               child: Text(
//                 //                 messageContent,
//                 //                 style: TextStyle(
//                 //                   fontSize: 20.0,
//                 //                 ),
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     );
//                 //   }
//                 // }
//
//                 final messageDubble = Dbquery(
//                   questionWidget: questionList,
//                   answerWidget: answerList,
//
//                   // chapterWidget: chapterWidget,
//                 );
//                 courseDetails.add(messageDubble);
//               }
//               return Column(
//                 children: courseDetails,
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class Dbquery extends StatelessWidget {
//   List<Widget> questionWidget = [];
//   List<Widget> answerWidget = [];
//   Dbquery({required this.answerWidget, required this.questionWidget});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [Text('$questionWidget'), Text('$answerWidget')],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Represents Homepage for Navigation
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        'https://firebasestorage.googleapis.com/v0/b/astrology-7cec1.appspot.com/o/work.pdf?alt=media&token=626db9e8-6ebd-4eea-9a32-43b5c61b446d',
        key: _pdfViewerKey,
      ),
    );
  }
}
