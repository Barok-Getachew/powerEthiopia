import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_viewer_page_controller.dart';

class VideoViewerPageView extends GetView<VideoViewerPageController> {
  const VideoViewerPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoViewerPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VideoViewerPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
