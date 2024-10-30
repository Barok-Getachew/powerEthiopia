import 'package:ethiosolar_app/app/data/models/support/support_model.dart';
import 'package:ethiosolar_app/app/data/models/support/support_response_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final RxList<String> supportPhoneNumbersList =
      List<String>.empty(growable: true).obs;
  RxBool isSupportLoading = false.obs;
  @override
  void onReady() async {
    await getAllSupport();
    super.onReady();
  }

  Future<void> getAllSupport() async {
    isSupportLoading(true);
    try {
      final ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kGetSupport,
        params: {},
        method: ApiMethod.GET,
      );
      if (response is BaseResponse) {
        final SupportResponseModel supportResponseModel = SupportResponseModel(
          supportModel: SupportModel.fromJsonList(response.results),
        );
        for (var support in supportResponseModel.supportModel) {
          supportPhoneNumbersList.addAll(
            support.phoneNumbers ?? [],
          );
        }
      }
    } catch (e) {
    } finally {
      isSupportLoading(false);
    }
  }
}
