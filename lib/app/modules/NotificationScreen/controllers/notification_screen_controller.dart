import 'package:ethiosolar_app/app/data/models/notification/notification_model.dart';
import 'package:ethiosolar_app/app/data/models/notification/notification_response.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  RxList<NotificationModel> notificationList =
      List<NotificationModel>.empty(growable: true).obs;

  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAllNotification();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAllNotification() async {
    notificationList.clear();
    isLoading(true);

    try {
      ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kNotification,
        method: ApiMethod.GET,
        useToken: true,
      );
      if (response is BaseResponse) {
        NotificationResponse notificationResponse = NotificationResponse(
          notificationList: NotificationModel.fromJsonList(response.results),
        );
        notificationList.addAll(notificationResponse.notificationList);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  void onTapNotificationWidget({required NotificationModel notification}) {
    try {
      if ((notification.productId != null &&
              notification.productId!.isNotEmpty) &&
          (notification.trainingId != null &&
              notification.trainingId!.isNotEmpty)) {
        return;
      }
      if (notification.productId != null &&
          notification.productId!.isNotEmpty) {
        final productId = int.tryParse(notification.productId!);
        Get.toNamed(Routes.productDetail, arguments: productId);
        return;
      }
      if (notification.trainingId != null &&
          notification.trainingId!.isNotEmpty) {
        final trainingId = int.tryParse(notification.trainingId!);
        Get.toNamed(
          Routes.playingScreen,
          arguments: trainingId,
        );
        return;
      }
    } on FormatException catch (e) {
      e.message;
    }
  }
}
