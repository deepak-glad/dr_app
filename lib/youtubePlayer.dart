import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Homepage
class MyHomePage extends StatefulWidget {
  String urls;

  MyHomePage(this.urls);

  @override
  _MyHomePageState createState() => _MyHomePageState(urls);
}

class _MyHomePageState extends State<MyHomePage> {
  YoutubePlayerController _controller;
  // TextEditingController _idController;
  // TextEditingController _seekToController;

  // PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  // double _volume = 100;
  // bool _muted = false;
  bool _isPlayerReady = false;
  String urls;

  _MyHomePageState(this.urls);

  /* final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];*/

  String getVideoID(String yurl) {
    RegExp regExp = new RegExp(
      r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(yurl).group(1); // <- This is the fix
    print('$yurl -> $match');
    return match;
  }

  @override
  void initState() {
    super.initState();
    _rotation = 0;
    SystemChrome.setEnabledSystemUIOverlays([]);

    String url = getVideoID(urls);
    print(url);
    _controller = YoutubePlayerController(
      initialVideoId: '$url?modestbranding=1&amp;rel=0&amp;showinfo=0',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        controlsVisibleAtStart: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    // _controller.cue(url);
    // _playerState = PlayerState.playing;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        // _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
    super.dispose();
  }

  int _rotation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RotatedBox(
        quarterTurns: _rotation,
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: YoutubePlayer(
                liveUIColor: Colors.transparent,
                progressColors:
                    ProgressBarColors(backgroundColor: Colors.transparent),
                onEnded: (_videoMetaData) {
                  Navigator.of(context).pop();
                },
                bottomActions: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: _rotation == 0
                              ? MediaQuery.of(context).size.width - 50
                              : MediaQuery.of(context).size.height - 50,
                          height: 100,
                          child: Row(children: [
                            RemainingDuration(),
                            ProgressBar(isExpanded: true),
                            CurrentPosition(),
                          ]),
                        ),
                        TextButton.icon(
                          label: Text(
                            _rotation == 0 ? 'FullScreen' : 'Exit fullscreen',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            _rotation == 0
                                ? Icons.fullscreen
                                : Icons.fullscreen_exit,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            _controller.pause();
                            if (_rotation == 0) {
                              setState(() {
                                _rotation = 1;
                              });
                            } else {
                              setState(() {
                                _rotation = 0;
                              });
                            }
                          },
                        ),
                      ]),
                ],
                controller: _controller,
                // showVideoProgressIndicator: false,
                progressIndicatorColor: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontWeight: FontWeight.w300,
//             fontSize: 16.0,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//         behavior: SnackBarBehavior.floating,
//         elevation: 1.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//       ),
//     );
//   }

// }
