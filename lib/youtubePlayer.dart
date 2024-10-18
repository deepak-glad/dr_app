import 'package:drkashikajain/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoFromYoutube extends StatefulWidget {
  final String urls;

  PlayVideoFromYoutube(this.urls);

  @override
  _PlayVideoFromVimeoIdState createState() => _PlayVideoFromVimeoIdState();
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoFromYoutube> {
  // late final PodPlayerController controller;
YoutubePlayerController ? controller;
bool isFullScreen=false;
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  // init(){
  //   controller = PodPlayerController(
  //   playVideoFrom: PlayVideoFrom.youtube(widget.urls,
  //   videoPlayerOptions: VideoPlayerOptions()),
  //   podPlayerConfig: const PodPlayerConfig(forcedVideoFocus: true, videoQualityPriority: [360,720]))
  //   ..initialise();
  //   controller.initialise();
  // }


  init(){
    controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(widget.urls)??"",
    flags:const YoutubePlayerFlags(
        autoPlay: true,
        forceHD:true,
        mute: false,
        hideThumbnail:true,
    ));
  }

  @override
  void didChangeDependencies() {
    // controller?.addListener(() {
    //   if (controller.isInitialised &&
    //       controller.currentVideoPosition == controller.totalVideoLength) {
        // SystemChrome.setPreferredOrientations(
        //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //     Navigator.of(context).pop(context);
    //   }
    // });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(

      appBar:isFullScreen?null: AppBar(
        backgroundColor: Colors.black,
        title: const Text(''),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close,color: AppColors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.bottomCenter,
            // mainAxisAlignment: MainAxisAlignment.center,
            // alignment: Alignment.bottomCenter,
            children: [
              
              // PodVideoPlayer(
              //   podProgressBarConfig: PodProgressBarConfig(
              //       playingBarColor: Colors.blue,
              //       bufferedBarColor: Colors.grey,
              //       backgroundColor: Colors.white,
              //       circleHandlerColor: Colors.blue),
              //   controller: controller,

              //   matchVideoAspectRatioToFrame: true,
              //   matchFrameAspectRatioToVideo: true,
              //   // overlayBuilder:(options) {

              //   // },
              // ),

               Center(
                 child: YoutubePlayerBuilder(
                  
                  onEnterFullScreen:() {
                     setState(() {
                    isFullScreen=true;    
                    }); },
                  onExitFullScreen: () {
                     setState(() {
                    isFullScreen=false;                     
                    }); },
                  player: YoutubePlayer(
                  controller:controller!,
                  onEnded:(metaData) {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
                    Navigator.pop(context);

                  },
                  ),
                  builder: (context, player){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                          player
                        ],
                      );}
                      ),
               ),
               if(!isFullScreen)
              TextButton.icon(
                  onPressed: () {
                    controller!.toggleFullScreenMode();
                    setState(() {
                    isFullScreen=true;
                      
                    });
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

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// /// Homepage
// class PlayVideoFromYoutube extends StatefulWidget {
//   final String urls;

//   PlayVideoFromYoutube(this.urls);

//   @override
//   _PlayVideoFromVimeoIdState createState() => _PlayVideoFromVimeoIdState();
// }

// class _PlayVideoFromVimeoIdState extends State<PlayVideoFromYoutube> {
//   YoutubePlayerController? _controller;
//   late TextEditingController _idController;
//   late TextEditingController _seekToController;

//   PlayerState? _playerState;
//   YoutubeMetaData? _videoMetaData;
//   double _volume = 100;
//   bool _muted = false;
//   bool _isPlayerReady = false;

//   // final List<String> _ids = [
//   //   'nPt8bK2gbaU',
//   //   'gQDByCdjUXw',
//   //   'iLnmTe5Q2Qw',
//   //   '_WoCV4c6XOE',
//   //   'KmzdUe0RSJo',
//   //   '6jZDSSZZxjQ',
//   //   'p2lYr3vM_1w',
//   //   '7QUtEmBT_-w',
//   //   '34_PXCzGw1M',
//   // ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.urls,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       ),
//     )..addListener(listener);
//     _idController = TextEditingController();
//     _seekToController = TextEditingController();
//     _videoMetaData = const YoutubeMetaData();
//     _playerState = PlayerState.unknown;
//   }

//   void listener() {
//     if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller!.value.playerState;
//         _videoMetaData = _controller!.metadata;
//       });
//     }
//   }

//   @override
//   void deactivate() {
//     // Pauses video while navigating to next page.
//     _controller!.pause();
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     _idController.dispose();
//     _seekToController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.urls);
//     print(widget.urls);
//     return YoutubePlayerBuilder(
//       onExitFullScreen: () {
//         // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//         SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//       },
//       player: YoutubePlayer(
//         controller: _controller!,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.blueAccent,
//         topActions: <Widget>[
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               _controller!.metadata.title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//               ),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.settings,
//               color: Colors.white,
//               size: 25.0,
//             ),
//             onPressed: () {
//               log('Settings Tapped!');
//             },
//           ),
//         ],
//         onReady: () {
//           _isPlayerReady = true;
//         },
//         onEnded: (data) {
//           _controller!.load(widget.urls);
//           _showSnackBar('Next Video Started!');
//         },
//       ),
//       builder: (context, player) => Scaffold(
//         // appBar: AppBar(),
//         body: ListView(
//           children: [
//             player,
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       _loadCueButton('LOAD'),
//                       const SizedBox(width: 10.0),
//                       _loadCueButton('CUE'),
//                     ],
//                   ),
//                   _space,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.skip_previous),
//                         onPressed: _isPlayerReady
//                             ? () => _controller!.load(widget.urls)
//                             : null,
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           _controller!.value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                         ),
//                         onPressed: _isPlayerReady
//                             ? () {
//                                 _controller!.value.isPlaying
//                                     ? _controller!.pause()
//                                     : _controller!.play();
//                                 setState(() {});
//                               }
//                             : null,
//                       ),
//                       IconButton(
//                         icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
//                         onPressed: _isPlayerReady
//                             ? () {
//                                 _muted
//                                     ? _controller!.unMute()
//                                     : _controller!.mute();
//                                 setState(() {
//                                   _muted = !_muted;
//                                 });
//                               }
//                             : null,
//                       ),
//                       FullScreenButton(
//                         controller: _controller,
//                         color: Colors.blueAccent,
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.skip_next),
//                         onPressed: _isPlayerReady
//                             ? () => _controller!.load(widget.urls)
//                             : null,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text(
//                         "Volume",
//                         style: TextStyle(fontWeight: FontWeight.w300),
//                       ),
//                       Expanded(
//                         child: Slider(
//                           inactiveColor: Colors.transparent,
//                           value: _volume,
//                           min: 0.0,
//                           max: 100.0,
//                           divisions: 10,
//                           label: '${(_volume).round()}',
//                           onChanged: _isPlayerReady
//                               ? (value) {
//                                   setState(() {
//                                     _volume = value;
//                                   });
//                                   _controller!.setVolume(_volume.round());
//                                 }
//                               : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                   _space,
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 800),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.0),
//                       color: _getStateColor(_playerState),
//                     ),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       _playerState.toString(),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _text(String title, String value) {
//     return RichText(
//       text: TextSpan(
//         text: '$title : ',
//         style: const TextStyle(
//           color: Colors.blueAccent,
//           fontWeight: FontWeight.bold,
//         ),
//         children: [
//           TextSpan(
//             text: value,
//             style: const TextStyle(
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color? _getStateColor(PlayerState? state) {
//     switch (state) {
//       case PlayerState.unknown:
//         return Colors.grey[700];
//       case PlayerState.unStarted:
//         return Colors.pink;
//       case PlayerState.ended:
//         return Colors.red;
//       case PlayerState.playing:
//         return Colors.blueAccent;
//       case PlayerState.paused:
//         return Colors.orange;
//       case PlayerState.buffering:
//         return Colors.yellow;
//       case PlayerState.cued:
//         return Colors.blue[900];
//       default:
//         return Colors.blue;
//     }
//   }

//   Widget get _space => const SizedBox(height: 10);

//   Widget _loadCueButton(String action) {
//     return Expanded(
//       child: MaterialButton(
//         color: Colors.blueAccent,
//         onPressed: _isPlayerReady
//             ? () {
//                 if (_idController.text.isNotEmpty) {
//                   var id = YoutubePlayer.convertUrlToId(
//                         _idController.text,
//                       ) ??
//                       '';
//                   if (action == 'LOAD') _controller!.load(id);
//                   if (action == 'CUE') _controller!.cue(id);
//                   FocusScope.of(context).requestFocus(FocusNode());
//                 } else {
//                   _showSnackBar('Source can\'t be empty!');
//                 }
//               }
//             : null,
//         disabledColor: Colors.grey,
//         disabledTextColor: Colors.black,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 14.0),
//           child: Text(
//             action,
//             style: const TextStyle(
//               fontSize: 18.0,
//               color: Colors.white,
//               fontWeight: FontWeight.w300,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

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
