import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/modules/NotificationScreen/widgets/notificationWidget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../core/i18n/translation_keys.dart' as trs;

import '../controllers/notification_screen_controller.dart';

class NotificationScreenView extends GetView<NotificationScreenController> {
  const NotificationScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            trs.notification.tr,
            style: theme.headlineSmall?.copyWith(
                color: Colors.black, overflow: TextOverflow.fade, fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    // physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.notificationList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 17,
                          ),
                          NotificationWidget(
                            onTap: () => controller.onTapNotificationWidget(
                                notification:
                                    controller.notificationList[index]),
                            title:
                                controller.notificationList[index].title ?? "",
                            description: controller
                                    .notificationList[index].description ??
                                "",
                            date: Utils.formatDateAsTimeAgo(
                              controller.notificationList[index].createdAt ??
                                  DateTime.now(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ));
  }
}
