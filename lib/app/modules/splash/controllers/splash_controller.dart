import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    final user = await UserSession.getUserData();
    debugPrint('usersplash: $user');
    if (user?.token == '' || user?.token == null || user == null) {
      debugPrint(user.toString());

      Get.offAllNamed(Routes.login);

      // await fetchUserbyId();
    } else {
      Get.offAllNamed(Routes.home);
    }

    super.onInit();
  }
}
