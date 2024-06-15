// ignore_for_file: implementation_imports

import 'dart:developer';
import 'package:am_innnn/utils/color.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../utils/api_url.dart';
import '../../../utils/styles.dart';

/// Stateful widget to fetch and then display video content.shakib
class NewsVideoPlayer extends StatefulWidget {
  final String? t;
  // final String? title;

  const NewsVideoPlayer({super.key, this.t});

  @override
  // ignore: library_private_types_in_public_api
  _NewsVideoPlayerState createState() => _NewsVideoPlayerState();
}

class _NewsVideoPlayerState extends State<NewsVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final playValue = ValueNotifier<bool>(false);
  final muteValue = ValueNotifier<bool>(false);
  final positionValue = ValueNotifier<String>('00:00');

  final t = 'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4';
  final t1 =
      'https://rr3---sn-4g5lznls.googlevideo.com/videoplayback?expire=1718276421&ei=5XxqZv_uA9PU6dsPmZmUoAs&ip=142.132.137.4&id=o-ACVnAuFtSfzIGMDOmBlEdRNSe4tJWoj_53z76K1FpCJk&itag=22&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&mh=JD&mm=31%2C26&mn=sn-4g5lznls%2Csn-f5f7lnld&ms=au%2Conr&mv=u&mvi=3&pl=24&bui=AbKP-1OF0Hon_h4bG9TgR9LQ1V74Zk1Yks2fY1JCDxNHXp4gDY9PQyjWZHI9AU_g0vWXPru732nIu1Az&vprv=1&mime=video%2Fmp4&rqh=1&cnr=14&ratebypass=yes&dur=36.269&lmt=1716798156162089&mt=1718253563&fvip=3&c=MEDIA_CONNECT_FRONTEND&txp=5432434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cvprv%2Cmime%2Crqh%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRgIhALgnckdr0TVI0LUsaizrWpbsxGyuCyJdD_dAemZn1b-IAiEAtpwMRX0vtiaOlg7Qfs9SI6NGPmFMNwW3PlHL-Om7bvk%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl&lsig=AHlkHjAwRQIgTE0R2esFhz309ZCQgAOHeWvQLPNqSsPAeh8ACEfhOewCIQD-WQu4s623l3b7gKzDY326Hts4qeiPUQKMXWmoyeiEEg%3D%3D&title=Top%2010%20Australian%20Bowlers%20of%20all%20Time%20%23shorts%20%23bowling%20%23cricket%20%23Mitchell%20stark';

  @override
  void initState() {
    // log('my player:     ${widget.t!}');
    super.initState();
    try {
      _videoPlayerController =
          // VideoPlayerController.networkUrl(Uri.parse('${widget.t}'))
          VideoPlayerController.networkUrl(
              Uri.parse('${ApiUrl.imageBaseUrl}${widget.t}'))
            // Uri.parse(t1))
            ..initialize().then((value) {
              setState(() {
                _chewieController = _setUpPlayer(_videoPlayerController);
              });
            });
      WakelockPlus.enable();
    } catch (e) {
      log('Error initializing video: $e');
    }
  }

  Widget _buildCustomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          VideoProgressIndicator(
            _videoPlayerController,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.white,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.transparent,
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // Row(
          //     //   mainAxisSize: MainAxisSize.min,
          //     //   children: [
          //     //     // IconButton(
          //     //     //   onPressed: () {
          //     //     //     if (_chewieController == null) return;
          //     //     //     //setState(() {
          //     //     //     if (_chewieController!.isPlaying) {
          //     //     //       _chewieController?.pause();
          //     //     //       playValue.value = true;
          //     //     //     } else {
          //     //     //       _chewieController?.play();
          //     //     //       playValue.value = false;
          //     //     //     }

          //     //     //     // });
          //     //     //   },
          //     //     //   icon: ValueListenableBuilder<bool>(
          //     //     //       valueListenable: playValue,
          //     //     //       builder: (context, value, _) {
          //     //     //         return Icon(
          //     //     //           value ? Icons.play_arrow_rounded : Icons.pause,
          //     //     //           // color: appThemeColor,
          //     //     //           color: Colors.white,
          //     //     //         );
          //     //     //       }),
          //     //     // ),
          //     //     // ValueListenableBuilder<String>(
          //     //     //   valueListenable: positionValue,
          //     //     //   builder: (context, value, child) => Text(
          //     //     //     value,
          //     //     //     style: mediumTS(Colors.white),
          //     //     //   ),
          //     //     // ),
          //     //   ],
          //     // ),
          //     // Row(
          //     //   mainAxisSize: MainAxisSize.min,
          //     //   children: [
          //     //     ValueListenableBuilder<bool>(
          //     //         valueListenable: muteValue,
          //     //         builder: (context, value, _) {
          //     //           return IconButton(
          //     //             onPressed: () async {
          //     //               //_chewieController?.
          //     //               if (value) {
          //     //                 await _videoPlayerController.setVolume(1);
          //     //                 muteValue.value = false;
          //     //               } else {
          //     //                 await _videoPlayerController.setVolume(0);
          //     //                 muteValue.value = true;
          //     //               }
          //     //             },
          //     //             icon: Icon(
          //     //               value ? Icons.volume_off : Icons.volume_up,
          //     //               // color: appThemeColor,
          //     //               color: Colors.white,
          //     //             ),
          //     //           );
          //     //         }),
          //     //     // IconButton(
          //     //     //   onPressed: () {
          //     //     //     _chewieController?.enterFullScreen();
          //     //     //   },
          //     //     //   icon: const Icon(
          //     //     //     Icons.fullscreen,
          //     //     //     // color: appThemeColor,
          //     //     //     color: Colors.white,
          //     //     //   ),
          //     //     // ),
          //     //   ],
          //     // ),
          //   ],
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null
        ? SizedBox(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  // bottom: 20,
                  // left: 16,
                  // right: 16,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Chewie(
                    controller: _chewieController!,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: _buildCustomControls(),
                //   // child: OptionsScreen(
                //   //   title: widget.title,
                //   // ),
                // )
              ],
            ),
          )
        : Center(
            child: Text(
            'Loading...',
            style: regularTS(appThemeColor),
          ));
    // IconButton(onPressed: (){
    //   final t = 'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4';
    //   _changeVideoSource(t);
    // }, icon: Icon(Icons.sanitizer_rounded))
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    playValue.dispose();
    muteValue.dispose();
    positionValue.dispose();
    WakelockPlus.disable();
  }

  void changeVideoSource(String newVideoUrl) {
    _chewieController?.pause();
    _chewieController?.dispose();
    setState(() {
      _chewieController = null;
    });

    final newVideoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(newVideoUrl));
    newVideoPlayerController.initialize().then((_) {
      _videoPlayerController.dispose();
      //_videoPlayerController = null;
      _videoPlayerController = newVideoPlayerController;

      _chewieController = _setUpPlayer(_videoPlayerController);

      // Play the new video

      setState(() {
        _chewieController?.play();
      });
    });
  }

  ChewieController _setUpPlayer(VideoPlayerController videoController) {
    final controller = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
      // aspectRatio: 16 / 9,
      aspectRatio: videoController.value.aspectRatio,
      // aspectRatio: 16 / 11.3,
      customControls: _buildCustomControls(),
      allowedScreenSleep: false,
      // fullScreenByDefault: true,
    );

    // Set up listeners and update UI as needed (similar to your initState logic)
    // videoController.addListener(() {
    //   final value =
    //       "${formatDuration(videoController.value.position)}/${formatDuration(videoController.value.duration)}";
    //   positionValue.value = value;
    // });
    return controller;
  }
}
