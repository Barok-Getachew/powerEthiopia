import 'package:get/get.dart';

import '../controllers/video_viewer_page_controller.dart';

class VideoViewerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoViewerPageController>(
      () => VideoViewerPageController(),
    );
  }
}
