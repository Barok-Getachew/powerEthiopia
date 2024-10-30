import 'package:get/get.dart';

import '../../../data/models/training/training_model.dart';
import '../../../data/models/training/training_response_model.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/api_constant.dart';
import '../../../data/services/api_response.dart';
import '../../../core/utils/store/user_session.dart';

class TrainingDetailPageController extends GetxController {
  late int trainingCategoryId;
  final RxList<TrainingModel> trainingList =
      List<TrainingModel>.empty(growable: true).obs;

  RxBool isTrainingCategoryTrainingsLoading = false.obs;
  String? token;

  @override
  void onInit() {
    trainingCategoryId = Get.arguments;
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await getUserToken();

    await getTrainingCategoryTrainings();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getTrainingCategoryTrainings() async {
    isTrainingCategoryTrainingsLoading(true);

    try {
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        endPoint:
            "${ApiConstant.kgetTrainingCategoryDetailApi}/$trainingCategoryId",
        mHeader: {
          "Authorization": "Bearer $token",
        },
      );
      if (response is BaseResponse) {
        TrainingResponseModel trainingResponseModel =
            TrainingResponseModel.fromJson(response.results);
        trainingList.addAll(trainingResponseModel.trainingList ?? []);
      }
    } catch (e) {
    } finally {
      isTrainingCategoryTrainingsLoading(false);
    }
  }

  Future<void> getUserToken() async {
    token = await UserSession.getUserToken();
  }
}
