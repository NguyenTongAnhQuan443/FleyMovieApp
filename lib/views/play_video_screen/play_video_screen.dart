import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class PlayVideoScreen extends StatefulWidget {
  String movieUrl;

  PlayVideoScreen(this.movieUrl);

  @override
  State<StatefulWidget> createState() {
    return _PlayVideoScreenState(movieUrl);
  }
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  String movieUrl;
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  double _currentSliderValue = 0.0;
  double _totalDuration = 0.0;

  _PlayVideoScreenState(this.movieUrl);

  @override
  void initState() {
    super.initState();
    // Lock the screen orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
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
    // Unlock the screen opeientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    super.dispose();
  }

  Orientation get orientation => MediaQuery.of(context).orientation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AspectRatio(
                        // _controller.value.aspectRatio,
                        aspectRatio: orientation == Orientation.portrait
                            ? 16 / 9
                            : screenWidth / screenHeight,
                        child: VideoPlayer(_controller),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: screenHeight - 80),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'data',
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(
                                  'data',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: double.infinity,
                              height: 8,
                              child: VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                  playedColor: Colors.red,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
          ),
          onTapArrowBack(),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight / 2 - 30, left: screenWidth / 2 - 30),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }

  // A
  Widget onTapArrowBack() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }
}
