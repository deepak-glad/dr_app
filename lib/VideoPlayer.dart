import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  String video;
  ChewieDemo(this.video);

  // ignore: use_key_in_widget_constructors

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState(video);
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  String video;
  _ChewieDemoState(this.video);
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(video);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _chewieController = ChewieController(
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        videoPlayerController: _videoPlayerController1,
        aspectRatio: _videoPlayerController1.value?.aspectRatio,
        autoPlay: true,
        looping: true,
        routePageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation, provider) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return Scaffold(
                // resizeToAvoidBottomPadding: false,
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: provider,
                ),
              );
            },
          );
        }
        // Try playing around with some of these other options:

        // showControls: false,
        // materialProgressColors: ChewieProgressColors(
        //   playedColor: Colors.red,
        //   handleColor: Colors.blue,
        //   backgroundColor: Colors.grey,
        //   bufferedColor: Colors.lightGreen,
        // ),
        // placeholder: Container(
        //   color: Colors.grey,
        // ),
        // autoInitialize: true,
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: _chewieController != null &&
                          _chewieController
                              .videoPlayerController.value.isInitialized
                      ? Chewie(
                          controller: _chewieController,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        ),
                ),
              )
            ],
          ),
        ));
  }
}
