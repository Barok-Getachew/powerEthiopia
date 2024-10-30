// ignore_for_file: unnecessary_overrides

import 'package:ethiosolar_app/app/data/models/carousel/carousel_model.dart';
import 'package:ethiosolar_app/app/data/models/carousel/carousel_response.dart';
import 'package:ethiosolar_app/app/data/models/training/training_model.dart';
import 'package:ethiosolar_app/app/data/models/training/training_request_model.dart';
import 'package:ethiosolar_app/app/data/models/training/training_response_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:get/get.dart';

class TrainingCategoryScreenController extends GetxController {
  final count = 0.obs;
  final RxList<TrainingModel> trainingList =
      List<TrainingModel>.empty(growable: true).obs;

  RxBool isTrainingCategoryLoading = false.obs;
  RxBool isCarouselImageLoading = true.obs;
  final RxList<CarouselModel> carouselList =
      List<CarouselModel>.empty(growable: true).obs;
  String? token;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    await getUserToken();
    await getCarouselItems();
    await getTrainingCategories();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getTrainingCategories() async {
    try {
      isTrainingCategoryLoading(true);
      Map<String, dynamic> trainingRequest =
          const TrainingRequestModel().toJson();

      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        params: trainingRequest,
        endPoint: ApiConstant.kgetTrainingCategoriesApi,
        mHeader: {
          "Authorization": "Bearer $token",
        },
      );
      if (response is BaseResponse) {
        TrainingResponseModel trainingResponseModel = TrainingResponseModel(
          trainingList: TrainingModel.fromJsonList(response.results),
        );
        trainingList.addAll(trainingResponseModel.trainingList ?? []);
      }
    } finally {
      isTrainingCategoryLoading(false);
    }
  }

  Future<void> getUserToken() async {
    token = await UserSession.getUserToken();
  }

  Future<void> getCarouselItems() async {
    isCarouselImageLoading(true);
    try {
      ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        params: {},
        endPoint: ApiConstant.kGetCarouselImages,
        useToken: true,
      );
      if (response is BaseResponse) {
        final CarouselResponse carouselResponse = CarouselResponse(
          carouselList: CarouselModel.fromJsonList(
            response.results,
          ),
        );
        carouselList.addAll(carouselResponse.carouselList);
      }
    } finally {
      isCarouselImageLoading(false);
    }
  }
}
