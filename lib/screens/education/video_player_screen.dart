import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://example.com/sample-video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gardening Lesson'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          VideoProgressIndicator(_controller, allowScrubbing: true),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _isPlaying ? _controller.pause() : _controller.play();
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                Expanded(
                  child: Slider(
                    value: _controller.value.position.inSeconds.toDouble(),
                    max: _controller.value.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _controller.seekTo(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Introduction to Gardening',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Learn the basics of starting your own garden, including soil preparation, plant selection, and basic care techniques.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}