import 'package:get/get.dart';

import '../controllers/aboutus_onboarding_controller.dart';

class AboutusOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutusOnboardingController>(
      () => AboutusOnboardingController(),
    );
  }
}
