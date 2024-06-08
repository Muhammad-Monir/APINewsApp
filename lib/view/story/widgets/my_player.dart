// ignore_for_file: implementation_imports

import 'dart:developer';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/view/story/widgets/options_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/src/helpers/utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../utils/styles.dart';

/// Stateful widget to fetch and then display video content.shakib
class MyPlayer extends StatefulWidget {
  final String? t;
  final String? title;

  const MyPlayer({super.key, this.t, this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final playValue = ValueNotifier<bool>(false);
  final muteValue = ValueNotifier<bool>(false);
  final positionValue = ValueNotifier<String>('00:00');

  // final u = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  // final t = 'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4';
  // final t = 'https://rr7---sn-5uh5o-f5f6.googlevideo.com/videoplayback?expire=1709143396&ei=BCHfZbeKDeSFi9oP2IyomA4&ip=138.199.59.207&id=o-AK1UkbqOrHevZcoSXQqhIIBu00kcCEYN-uJs2EHFAtdO&itag=22&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&mh=NH&mm=31%2C29&mn=sn-5uh5o-f5f6%2Csn-5hne6nzd&ms=au%2Crdu&mv=m&mvi=7&pl=24&initcwndbps=1115000&spc=UWF9f2sGNQ37cZdRd7UIlGI6kgSBsU60LFZFBKy3wXrQtB4&vprv=1&svpuc=1&mime=video%2Fmp4&cnr=14&ratebypass=yes&dur=25.518&lmt=1618938055523511&mt=1709121432&fvip=1&fexp=24007246&c=ANDROID&txp=6316222&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRgIhAOR33Hx6-UChnhAN6DjmJE6pLKndsAR4odzBsBTbRVqfAiEA_ZDO9y_W498Mlnp2FpfcOPFZBjEBU5ge1Sir1988DLY%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=APTiJQcwRgIhAJMSwWz2_Xsymjjs-SqGG2AcS8HDJ6Cvq3iY_sL2nfh5AiEA1jPjQ_cnA5Sfq5zhZBK7LjD1Kp1bzRzhVjvYGwHrZgU%3D&title=Professor%F0%9F%98%8D%20%7C%20Money%20Heist%E2%9D%A4%EF%B8%8F%20%7C%20Attitude%20status%20%7C%20La%20Casa%20De%20Papel';
  // final t = 'https://rr2---sn-ugp5obax-q5je.googlevideo.com/videoplayback?expire=1709131423&ei=P_LeZZv4Nc3ezLUPmemW8AY&ip=64.43.111.3&id=o-ADGHoQ70Uwb2La2p74qZeTePRAdMNBNGHnqFBNqQHhz6&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&spc=UWF9f6bBHXoAj3ymX7RcAApaP80_3C7j_vcs5trFtact_Tk&vprv=1&svpuc=1&mime=video%2Fmp4&gir=yes&clen=3348370&ratebypass=yes&dur=44.458&lmt=1708985305056914&fexp=24007246&c=ANDROID&txp=5530434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRgIhAIGWJ7KlGk3M7Qr9RLVkvKThQUbUKExyBoIxLCLc-XaMAiEAkWENTOH4dODRN1T7M8UgJf-Nn-3oa-5qsKJ9CENxGOM%3D&title=Apple%20Phone%20Screen%20Protector%20Applying%20Process%20%23shorts&redirect_counter=1&rm=sn-ab5eld76&req_id=259f5503c6d0a3ee&cms_redirect=yes&cmsv=e&ipbypass=yes&mh=r8&mip=103.161.8.1&mm=31&mn=sn-ugp5obax-q5je&ms=au&mt=1709109660&mv=m&mvi=2&pl=24&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=APTiJQcwRAIgUl2SfOzgaOjbKhlkrILxD7ww0YS5tXfeFtO85mjoix0CIBYFaldAZsiP-k0KCOck1pRBILBFdj5YGdUIHcGCFXkr';
  // final t = 'https://192.168.40.38/Am_inn/public/uploads/meme_videos/asdgasdg-bz3tyg76nd1hbpv6wsugcqajascenm.mp4';
  // final t = 'https://192.168.40.38/Am_inn/public/uploads/meme_videos/asdgasdg-bz3tyg76nd1hbpv6wsugcqajascenm.mp4';
  @override
  void initState() {
    log('my player:     ${widget.t!}');
    super.initState();
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse('${widget.t}'))
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_chewieController == null) return;
                      //setState(() {
                      if (_chewieController!.isPlaying) {
                        _chewieController?.pause();
                        playValue.value = true;
                      } else {
                        _chewieController?.play();
                        playValue.value = false;
                      }

                      // });
                    },
                    icon: ValueListenableBuilder<bool>(
                        valueListenable: playValue,
                        builder: (context, value, _) {
                          return Icon(
                            value ? Icons.play_arrow_rounded : Icons.pause,
                            // color: appThemeColor,
                            color: Colors.white,
                          );
                        }),
                  ),
                  // ValueListenableBuilder<String>(
                  //   valueListenable: positionValue,
                  //   builder: (context, value, child) => Text(
                  //     value,
                  //     style: mediumTS(Colors.white),
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: muteValue,
                      builder: (context, value, _) {
                        return IconButton(
                          onPressed: () async {
                            //_chewieController?.
                            if (value) {
                              await _videoPlayerController.setVolume(1);
                              muteValue.value = false;
                            } else {
                              await _videoPlayerController.setVolume(0);
                              muteValue.value = true;
                            }
                          },
                          icon: Icon(
                            value ? Icons.volume_off : Icons.volume_up,
                            // color: appThemeColor,
                            color: Colors.white,
                          ),
                        );
                      }),
                  IconButton(
                    onPressed: () {
                      _chewieController?.enterFullScreen();
                    },
                    icon: const Icon(
                      Icons.fullscreen,
                      // color: appThemeColor,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          )
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // child: _buildCustomControls(),
                  child: OptionsScreen(
                    title: widget.title,
                  ),
                )
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator()

            //   Text(
            //   'Loading...',
            //   style: regularTS(appThemeColor),
            // )
            );
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
      // aspectRatio: 0.48,
      customControls: _buildCustomControls(),
      allowedScreenSleep: false,
      // fullScreenByDefault: true,
    );

    // Set up listeners and update UI as needed (similar to your initState logic)
    videoController.addListener(() {
      final value =
          "${formatDuration(videoController.value.position)}/${formatDuration(videoController.value.duration)}";
      positionValue.value = value;
    });
    return controller;
  }
}
