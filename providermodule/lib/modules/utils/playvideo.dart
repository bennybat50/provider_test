import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:native_video_view/native_video_view.dart';

class PlayVideo extends StatefulWidget {
  final bool online;
  final String url, title;
  const PlayVideo({Key key, this.online, this.url, this.title})
      : super(key: key);
  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          '${widget.title ?? ""}',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Ionicons.ios_close,
            size: 40,
          ),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 28.0),
        child: Center(
          child: widget.url == null
              ? Text(
                  'No video file available',
                  style: TextStyle(color: Colors.white),
                )
              : SingleChildScrollView(
                  child: NativeVideoView(
                    keepAspectRatio: true,
                    showMediaController: true,
                    onCreated: (controller) {
                      controller.setVideoSource(
                        widget.url,
                        sourceType: widget.online
                            ? VideoSourceType.network
                            : VideoSourceType.asset,
                      );
                    },
                    onPrepared: (controller, info) {
                      controller.play();
                    },
                    onError: (controller, what, extra, message) {
                      //print('Player Error ($what | $extra | $message)');
                    },
                    onCompletion: (controller) {
                      // print('Video completed');
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
