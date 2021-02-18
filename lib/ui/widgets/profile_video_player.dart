
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProfileVideoPlayer extends StatefulWidget {
  ProfileVideoPlayer(
      {@required this.videoPath,

        @required this.name,
        @required this.author});
  final String videoPath;
  final String name;
  final String author;
  @override
  _ProfileVideoPlayerState createState() => _ProfileVideoPlayerState();
}

class _ProfileVideoPlayerState extends State<ProfileVideoPlayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  var _progress = 0.0;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(widget.videoPath);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      key: _scaffoldKey,

      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      child:  Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.

                return GestureDetector(
                  onTap: () {
                    if (_controller.value.isPlaying){

                      _controller.pause();
                    } else{
                      _controller.play();

                    }

                  },
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: _progress,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      )
                    ],
                  ),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}