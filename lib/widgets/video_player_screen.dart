import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../const/colors.dart';
import 'all_widgets.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? adVideo;

  const VideoPlayerScreen({
    Key? key,
    this.adVideo,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  ///Video Controller
  late VideoPlayerController videoPlayerController;

  var isMuted;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
      widget.adVideo!,
    )..initialize().then(
        (value) {
          setState(
            () {
              videoPlayerController.play();
            },
          );
          videoPlayerController.setLooping(true);
          videoPlayerController.setVolume(0);
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Value changed Mute/Unmute
    isMuted = videoPlayerController.value.volume == 0;

    // ignore: unnecessary_null_comparison
    return (videoPlayerController != null &&
            videoPlayerController.value.isInitialized)
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: fullWidth(context),
                    height: fullHeight(context) * 0.25,
                    child: VideoPlayer(
                      videoPlayerController,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        isMuted
                            ? Icons.volume_off_rounded
                            : Icons.volume_up_rounded,
                        color: white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            videoPlayerController.setVolume(isMuted ? 1 : 0);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: progressIndicator(context),
          );
  }
}
