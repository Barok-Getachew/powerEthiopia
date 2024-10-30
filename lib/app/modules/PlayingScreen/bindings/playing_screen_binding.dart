import 'package:get/get.dart';

import '../controllers/playing_screen_controller.dart';

class PlayingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayingScreenController>(
      () => PlayingScreenController(),
    );
  }
}
