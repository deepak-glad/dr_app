import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';

class PlayVideoFromYoutube extends StatefulWidget {
  final String urls;

  PlayVideoFromYoutube(this.urls);

  @override
  _PlayVideoFromVimeoIdState createState() => _PlayVideoFromVimeoIdState(urls);
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoFromYoutube> {
  String urls;
  _PlayVideoFromVimeoIdState(this.urls);
  PodPlayerController controller;
  final videoTextFieldCtr = TextEditingController();
  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(urls),
        podPlayerConfig: const PodPlayerConfig(forcedVideoFocus: true))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    print('deepak');
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    controller.addListener(() {
      if (controller.isInitialised &&
          controller.currentVideoPosition == controller.totalVideoLength) {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        Navigator.of(context).pop(context);
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // controller.addListener(checkIsFinished);
    // final ValueNotifier<bool> _isVideoFinished = useState(false);
    //
    // void checkIsFinished() {
    //   _isVideoFinished.value = controller.isInitialised &&
    //       controller.currentVideoPosition ==
    //           controller.totalVideoLength;
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(''),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            // alignment: Alignment.bottomCenter,
            children: [
              PodVideoPlayer(
                podProgressBarConfig: PodProgressBarConfig(
                    playingBarColor: Colors.blue,
                    bufferedBarColor: Colors.grey,
                    backgroundColor: Colors.white,
                    circleHandlerColor: Colors.blue),
                controller: controller,
                matchVideoAspectRatioToFrame: true,
                matchFrameAspectRatioToVideo: true,
                // overlayBuilder:(options) {

                // },
              ),
              TextButton.icon(
                  onPressed: () {
                    controller.enableFullScreen();
                  },
                  label: Text(
                    'Full Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.fullscreen, color: Colors.white))
            ]),
      ),
    );
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }
}
