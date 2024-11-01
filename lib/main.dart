import 'package:ethiosolar_app/app/core/services/local_notfications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

import 'app/core/di/main_services.dart';
import 'app/core/i18n/messages.dart';
import 'app/core/utils/theme/theme.dart';
import 'app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

abstract class BuildContextX {
  static BuildContext get context =>
      NavigationService.navigatorKey.currentContext!;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ProfileScreenController(), permanent: true);
  // Make sure to add the required packages to pubspec.yaml:
  // * https://github.com/media-kit/media-kit#installation
  // * https://pub.dev/packages/media_kit#installation
  MediaKit.ensureInitialized();
  await NotificationService().initialize;
  await initServices();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: "Power Ethiopia",
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        theme: light_theme,
        translations: Messages(),
        locale: const Locale('en', 'EN'),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

Future<void> initServices() async {
  await Get.putAsync<MainServices>(() async => MainServices());
}
