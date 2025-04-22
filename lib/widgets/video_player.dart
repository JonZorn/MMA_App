import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:video_player/video_player.dart';

class VideoPlayers extends StatefulWidget {
  final String? video;
  VideoPlayers({Key? key, this.video}) : super(key: key);

  @override
  _VideoPlayersState createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  // VideoPlayerController _controller;
  // FlickManager flickManager;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
        widget.video!.contains("https")
            ? widget.video!
            : "https://mmaflashcards.com/cards/videos/${widget.video}");
    videoPlayerController!.setVolume(0.0);

    // _controller.setPlaybackSpeed(.10);
    // _controller.setLooping(true);
    chewieController = ChewieController(
        useRootNavigator: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: DayTheme.primaryColor,
        ),
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: DayTheme.primaryColor,
        ),
        aspectRatio: 16 / 9,
        allowMuting: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: true,
        autoInitialize: true);

    chewieController!.addListener(() {
      if (chewieController!.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
    // flickManager = FlickManager(
    //   videoPlayerController: _controller,
    // );
    super.initState();
  }

  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController.dispose();
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   // flickManager.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.video);
    return Container(
        child: widget.video != null
            ? Chewie(
                controller: chewieController!,
              )
            : Center(
                child: CircularProgressIndicator(
                color: DayTheme.primaryColor,
              ))

        //     FlickVideoPlayer(
        //   flickManager: flickManager,
        // )
        );
  }
}
