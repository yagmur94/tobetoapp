import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobetoapp/widgets/validation_video_controller.dart';

// Biz Kimiz - video için

class ControlsOverlay extends StatelessWidget {
  static const _iconSize = 30.0;

  const ControlsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = Provider.of<VideoController>(context);
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: videoController.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: _iconSize,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: videoController.playPause,
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: videoController.toggleFullScreen,
            icon: const Icon(
              Icons.fullscreen,
              color: Colors.white,
              size: _iconSize,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              IconButton(
                onPressed: videoController.toggleVolume,
                icon: Icon(
                  videoController.controller.value.volume > 0
                      ? Icons.volume_up
                      : Icons.volume_off,
                  color: Colors.white,
                  size: _iconSize,
                ),
              ),
              Text(
                '${videoController.positionString} / ${videoController.durationString}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
