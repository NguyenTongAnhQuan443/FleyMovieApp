import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class PlayVideoScreen extends StatefulWidget {
  final String movieUrl;

  PlayVideoScreen(this.movieUrl, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayVideoScreenState(movieUrl);
  }
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  String movieUrl;
  late VideoPlayerController _controller;
  double _currentSliderValue = 0.0;
  double _totalDuration = 0.0;
  bool _showControls = true;
  Timer? _hideControlsTimer;
  bool _isPause = false;

  _PlayVideoScreenState(this.movieUrl);

  @override
  void initState() {
    super.initState();
    // Lock the screen orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = VideoPlayerController.network(movieUrl)
      ..initialize().then((_) {
        setState(() {
          _totalDuration = _controller.value.duration.inSeconds.toDouble();
        });
      });
    _controller.addListener(() {
      setState(() {
        _currentSliderValue = _controller.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // Unlock the screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    _hideControlsTimer?.cancel(); // Cancel the timer when disposing the screen
    super.dispose();
  }

  void _toggleControlsVisibility() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startTimerToHideControls();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  void _startTimerToHideControls() {
    _hideControlsTimer?.cancel(); // Cancel any previous timer
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  Orientation get orientation => MediaQuery.of(context).orientation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: GestureDetector(
        onTap: _toggleControlsVisibility,
        child: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: orientation == Orientation.portrait
                        ? 16 / 9
                        : screenWidth / screenHeight,
                    child: VideoPlayer(_controller),
                  ),
                  if (_showControls)
                    Positioned(
                      bottom: 42,
                      left: 5,
                      right: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(_currentSliderValue.toInt()),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            formatDuration(_totalDuration.toInt()),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  if (_showControls)
                    Container(
                      margin: const EdgeInsets.only(
                          left: 70, right: 70, bottom: 50),
                      width: double.infinity,
                      height: 8,
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: Colors.red,
                          backgroundColor: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                ],
              )
                  : const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            if (_showControls)
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                ),
              ),
            Positioned(
              top: screenHeight / 2 - 30,
              left: screenWidth / 2 - 30,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? (_controller.pause(), _isPause = true)
                        : (_controller.play(), _isPause = false);
                  });
                  _toggleControlsVisibility(); // Show controls when play/pause button is pressed
                },
                icon: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }
}
