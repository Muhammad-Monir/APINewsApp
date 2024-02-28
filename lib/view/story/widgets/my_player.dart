import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/src/helpers/utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../utils/styles.dart';

/// Stateful widget to fetch and then display video content.shakib
class MyPlayer extends StatefulWidget {
  const MyPlayer({super.key});

  @override
  _MyPlayerState createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final playValue = ValueNotifier<bool>(false);
  final muteValue = ValueNotifier<bool>(false);
  final positionValue = ValueNotifier<String>('00:00');
  final u = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  // final t = 'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4';
  final t = 'https://rr2---sn-ugp5obax-q5je.googlevideo.com/videoplayback?expire=1709131423&ei=P_LeZZv4Nc3ezLUPmemW8AY&ip=64.43.111.3&id=o-ADGHoQ70Uwb2La2p74qZeTePRAdMNBNGHnqFBNqQHhz6&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&spc=UWF9f6bBHXoAj3ymX7RcAApaP80_3C7j_vcs5trFtact_Tk&vprv=1&svpuc=1&mime=video%2Fmp4&gir=yes&clen=3348370&ratebypass=yes&dur=44.458&lmt=1708985305056914&fexp=24007246&c=ANDROID&txp=5530434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRgIhAIGWJ7KlGk3M7Qr9RLVkvKThQUbUKExyBoIxLCLc-XaMAiEAkWENTOH4dODRN1T7M8UgJf-Nn-3oa-5qsKJ9CENxGOM%3D&title=Apple%20Phone%20Screen%20Protector%20Applying%20Process%20%23shorts&redirect_counter=1&rm=sn-ab5eld76&req_id=259f5503c6d0a3ee&cms_redirect=yes&cmsv=e&ipbypass=yes&mh=r8&mip=103.161.8.1&mm=31&mn=sn-ugp5obax-q5je&ms=au&mt=1709109660&mv=m&mvi=2&pl=24&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=APTiJQcwRAIgUl2SfOzgaOjbKhlkrILxD7ww0YS5tXfeFtO85mjoix0CIBYFaldAZsiP-k0KCOck1pRBILBFdj5YGdUIHcGCFXkr';



  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      t
        ))
      ..initialize().then((value) {
        setState(() {
          _chewieController = _setUpPlayer(_videoPlayerController);
        });
      });
    WakelockPlus.enable();
  }

  Widget _buildCustomControls() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // VideoProgressIndicator(
          //   _videoPlayerController,
          //   allowScrubbing: true,
          //   colors: const VideoProgressColors(
          //     playedColor: Colors.white,
          //     bufferedColor: Colors.grey,
          //     backgroundColor: Colors.transparent,
          //   ),
          // ),
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
                        onPressed: () async{
                          //_chewieController?.
                          if(value){
                            await _videoPlayerController.setVolume(1);
                            muteValue.value = false;
                          }else{
                            await _videoPlayerController.setVolume(0);
                            muteValue.value = true;
                          }
                        },
                        icon:  Icon(
                         value? Icons.volume_off: Icons.volume_up,
                          color: Colors.white,
                        ),
                      );
                    }
                  ),
                  IconButton(
                    onPressed: () {
                      _chewieController?.enterFullScreen();
                    },
                    icon: const Icon(
                      Icons.fullscreen,
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
          // )
        ],
      ),
    )
        : Center(child: Text('Loading...', style: regularTS(Colors.white),));
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

  ChewieController _setUpPlayer(VideoPlayerController videoController){
    final controller = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
      aspectRatio: videoController.value.aspectRatio,
      customControls: _buildCustomControls(),
      allowedScreenSleep: false,
      // fullScreenByDefault: true,
      controlsSafeAreaMinimum: EdgeInsets.all(20)
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
