import 'package:flutter/material.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:wakelock/wakelock.dart';

class NativePlayer extends StatefulWidget {
  NativePlayer(
      {required this.vedioUrl,
      required this.videoDescription,
      required this.videoTitle});

  final String vedioUrl;
  final String videoTitle;
  final String videoDescription;

  @override
  _NativePlayerState createState() => _NativePlayerState();
}

class _NativePlayerState extends State<NativePlayer> {
  final _meeduPlayerController = MeeduPlayerController(
      controlsStyle: ControlsStyle.primary,
      enabledButtons: EnabledButtons(videoFit: false));

  @override
  void initState() {
    super.initState();
// The following line will enable the Android and iOS wakelock.
    Wakelock.enable();

    // Wait until the fisrt render the avoid posible errors when use an context while the view is rendering
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    // The next line disables the wakelock again.
    Wakelock.disable();
    _meeduPlayerController.dispose(); // release the video player
    super.dispose();
  }

  /// play a video from network
  _init() {
    _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.network,
        source: "${widget.vedioUrl}",
      ),
      autoplay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size.width / 5;
    return Scaffold(
      appBar: AppBar(
        title: Text("Free Vedio"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: MeeduVideoPlayer(
                  controller: _meeduPlayerController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey.withOpacity(0.2),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: m,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('images/admin.jpg'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - m,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.videoTitle}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
        ),
      ),
    );
  }
}
