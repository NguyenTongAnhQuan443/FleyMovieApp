import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class PlayVideoScreen extends StatefulWidget {
  final String movieUrl;

  const PlayVideoScreen(this.movieUrl, {super.key});

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
  bool _lockScreen = false;

  _PlayVideoScreenState(this.movieUrl);

  @override
  void initState() {
    super.initState();
    // Lock the screen orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // Hide the status bar and navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = VideoPlayerController.networkUrl(Uri.parse(movieUrl))
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
    // Unlock the screen orientation and show the status bar and navigation bar
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _toggleControlsVisibility() {
    if (!_lockScreen) {
      setState(() {
        _showControls = !_showControls;
        if (_showControls) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        }
      });
      if (_showControls && !_isPause) {
        _startTimerToHideControls();
      } else {
        _hideControlsTimer?.cancel();
      }
    } else {
      // When screen is locked, only show the lock icon
      setState(() {
        _showControls = false;
      });
    }
  }

  void _startTimerToHideControls() {
    _hideControlsTimer?.cancel(); // Cancel any previous timer
    _hideControlsTimer = Timer(const Duration(seconds: 4), () {
      setState(() {
        if (!_isPause && !_lockScreen) {
          _showControls = false;
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        }
      });
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPause = true;
        _hideControlsTimer?.cancel(); // Cancel timer when paused
      } else {
        _controller.play();
        _isPause = false;
        _startTimerToHideControls(); // Restart timer when playing
      }
    });
  }

  void _replayVideo() {
    final newPosition =
        _controller.value.position - const Duration(seconds: 10);
    _controller
        .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _forwardVideo() {
    final newPosition =
        _controller.value.position + const Duration(seconds: 10);
    final duration = _controller.value.duration;
    _controller.seekTo(newPosition < duration ? newPosition : duration);
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
                        if (_showControls && !_lockScreen) buildDuration(),
                        if (_showControls && !_lockScreen) buildProgressVideo(),
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ),
            if (_showControls && !_lockScreen) buildIconBack(),
            if (_showControls && !_lockScreen) buildReplayPauseforwardVideo(),
            buildLockScreen(),
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

  // Build Icon Back
  Widget buildIconBack() {
    return Positioned(
      top: 20,
      left: 20,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  // Build Replay-Pause-forward-Video
  Widget buildReplayPauseforwardVideo() {
    return Positioned.fill(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _replayVideo();
                  },
                  icon: const Icon(
                    Icons.replay_10,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  width: 180,
                ),
                IconButton(
                  onPressed: _togglePlayPause,
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 180,
                ),
                IconButton(
                  onPressed: () {
                    _forwardVideo();
                  },
                  icon: const Icon(
                    Icons.forward_10,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget Duration
  Widget buildDuration() {
    return Positioned(
      bottom: 42,
      left: 5,
      right: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDuration(_currentSliderValue.toInt()),
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            formatDuration(_totalDuration.toInt()),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

// Widget build Progress video
  Widget buildProgressVideo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 70, right: 70, bottom: 50),
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
    );
  }

  Widget buildLockScreen() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: IconButton(
        onPressed: () {
          setState(() {
            _lockScreen = !_lockScreen;
            if (_lockScreen) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            } else {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            }
          });
        },
        icon: Icon(
          (_lockScreen) ? Icons.lock_outline_rounded : Icons.lock_open_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
