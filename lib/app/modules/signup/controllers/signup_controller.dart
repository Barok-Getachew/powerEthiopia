import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';

import 'package:ethiosolar_app/app/data/models/city/city_model.dart';
import 'package:ethiosolar_app/app/data/models/city/city_responnse_model.dart';
import 'package:ethiosolar_app/app/data/models/login_model.dart';
import 'package:ethiosolar_app/app/data/models/term_condition/term_condition_model.dart';
import 'package:ethiosolar_app/app/data/models/term_condition/term_response_model.dart';
import 'package:ethiosolar_app/app/data/models/user_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/media/image_picker.dart';
import '../../../core/utils/media/media_type.dart';

class SignupController extends GetxController {
  //media type
  final MediaTypeUtil _mediaType = MediaTypeUtil();
  RxInt activeStep = 0.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  List<CityModel> suggestionsCallback(String pattern) {
    return cities.where((product) {
      final nameLower = product.name?.toLowerCase().split(' ').join('') ?? '';
      final patternLower = pattern.toLowerCase().split(' ').join('');
      return nameLower.contains(patternLower);
    }).toList();
  }

  final RxList<TermModel> termModelList =
      List<TermModel>.empty(growable: true).obs;
  RxBool isAboutLoading = false.obs;

  //conrollers
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final lastNameController = TextEditingController();
  final jobNameController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();
  //city dropdown menu
  var selectedItem = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isCityLoading = false.obs;

  var selectedCity = ''.obs;
  final RxList<CityModel> cities = List<CityModel>.empty(growable: true).obs;

  void selectItem(String item) {
    selectedItem.value = item;
  }

  final ImagePickerUtil _imagePickerUtil = ImagePickerUtil();
  File? selectedImage;
  RxList<File?> selectedMultipleImagesObs = <File>[].obs;
  List<File?> selectedMultipleImages = [];
  RxString fileNameObs = ''.obs;
  String? filename;
  List<String?> filenames = [];

  RxList<RxString> multiSelectedNameObs = <RxString>[].obs;
  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    print(isPasswordVisible.value);
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<(File?, RxString)> selectPicture() async {
    final pickedImage =
        await _imagePickerUtil.getImage(source: ImageSource.gallery);

    selectedImage = pickedImage.$1;
    fileNameObs.value = pickedImage.$2;

    return (selectedImage, fileNameObs);
  }

  Future<void> selectPictureFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedMultipleImagesObs.add(File(pickedFile.path));
    }
  }

  Future<(List<File?>, List<RxString>)> selectMultiplePicture() async {
    selectedMultipleImagesObs.clear();
    final pickedImage =
        await _imagePickerUtil.getImages(source: ImageSource.gallery);

    selectedMultipleImages = pickedImage.$1;
    // selectedMultipleImagesObs.addAll(pickedImage.$1);
    selectedMultipleImagesObs
        .addAll(pickedImage.$1.where((file) => file != null).cast<File>());
    debugPrint("file path${selectedMultipleImagesObs.map((e) => e!.path)}");
    // trainingList.addAll(trainingResponseModel.trainingList ?? []);

    multiSelectedNameObs.value =
        (pickedImage.$2).map((name) => RxString(name)).toList();
    debugPrint("file name${multiSelectedNameObs.map((e) => e.value)}");

    return (selectedMultipleImages, multiSelectedNameObs);
  }

  // focus nodes
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode cityFoCusNod = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode jobNameFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var isChecked = false.obs;

  void toggle() {
    isChecked.value = !isChecked.value;
  }

  // this function is used to focus to the next input field
  void onSubmittedPhone(String? value, BuildContext context) {
    FocusScope.of(context).requestFocus(fullNameFocusNode);
  }

  Map<String, dynamic> getSignUpReq(
      {required String fullName,
      required String phoneNnumber,
      required String country,
      required String description,
      required String password,
      required List<String?> imageUrl,
      required String status}) {
    SignUpReq req = SignUpReq(
      fullName: fullName,
      phoneNumber: phoneNnumber,
      country: country,
      description: description,
      password: password,
      imageUrl: imageUrl,
      status: 'Pending',
    );
    return req.toJson();
  }

  Future<void> signup({
    required String fullname,
    required String phoneNumber,
    required String country,
    required String description,
    required String password,
  }) async {
    if (country.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseSelectCity.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (description.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseEnterJobDescription.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (fullname.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseEnterFullName.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (password.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseEnterPassword.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (phoneNumber.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseEnterYourPhoneNumber.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (phoneNumber.length != 9) {
      Get.snackbar(
        error.tr,
        pleaseEnterValidPhoneNumber.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (password.length < 6) {
      Get.snackbar(
        error.tr,
        passwordMust.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (selectedMultipleImages.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseUpload.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      List<dio.MultipartFile> files = [];

      for (var image in selectedMultipleImages) {
        dio.MultipartFile multipartFile = await dio.MultipartFile.fromFile(
          image!.path,
          filename: image.path.split('/').last,
          contentType: _mediaType.getMediaType(image.path.split('/').last),
        );
        files.add(multipartFile);
      }

      dio.FormData formDataList = dio.FormData.fromMap({
        "files": files,
      });
      try {
        isLoading.value = true;
        debugPrint('here 1');

        debugPrint('here 2');

        ApiResponse? responseUpload = await ApiClient.instance.call(
          mHeader: {
            'Content-Type': 'multipart/form-data',
          },
          endPoint: ApiConstant.kuploadMultipleImage,
          method: ApiMethod.MULTIPART,
          fileUploadData: formDataList,
          // params: params
        );
        debugPrint('here 3 ');

        if (responseUpload is BaseResponse) {
          debugPrint('signup succesful code ${responseUpload.results}');
          debugPrint(
              'signup succesful code ${responseUpload.results['filenames']}');
          filenames = responseUpload.results['filenames'].cast<String>();
          debugPrint('image succesful code $filenames');
          // mapping to toJson
          Map<String, dynamic> params = getSignUpReq(
              fullName: fullname,
              phoneNnumber: phoneNumber,
              country: country,
              description: description,
              password: password,
              imageUrl: filenames,
              status: 'Pending');
          //instantiate the api client
          ApiResponse? response = await ApiClient.instance.call(
              mHeader: {
                'Content-Type': 'application/json',
              },
              endPoint: ApiConstant.ksignUpApi,
              method: ApiMethod.POST,
              params: params);

          if (response is BaseResponse) {
            debugPrint(
                'signup succesful ${response.results}  response ${response.results.runtimeType}');
            if (response.results['id'] != '') {
              debugPrint(
                  'onn elseif ${response.results['id']}  || ${response.results}');
              UserModel loginData = UserModel.fromJson(response.results);
              debugPrint('login data: $loginData');
              debugPrint('is user valid ${loginData.id}');

              isLoading.value = false;

              Get.offAllNamed(Routes.registrationPayment,
                  parameters: {'userId': loginData.id.toString()});
            } /* else {
              isLoading.value = false;

              Get.snackbar(
                'Error',
                '${response.results}',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            } */

            // login successful
            // store token, user info etc
            // await Get.offNamed('/home');
          } else {
            isLoading.value = false;
            if (response is ErrorResponse) {
              Get.snackbar(
                error.tr,
                response.errorMessage,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          }
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          e.toString() ?? '',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> fetchCities() async {
    try {
      ApiResponse? response = await ApiClient.instance.call(
        endPoint: ApiConstant.kgetCities,
        method: ApiMethod.GET,
      );
      if (response is BaseResponse) {
        CityResponseModel trainingResponseModel = CityResponseModel(
          cityList: CityModel.fromJsonList(response.results),
        );
        cities.addAll(trainingResponseModel.cityList ?? []);
        if (cities.isNotEmpty) {
          selectedCity.value = cities.first.id.toString();
        }
      }
    } finally {
      isCityLoading(false);
    }
  }

  Future<void> getTerm() async {
    isAboutLoading(true);
    try {
      final ApiResponse? response = await ApiClient.instance.call(
        method: ApiMethod.GET,
        endPoint: ApiConstant.kgetTermAndCondition,
        useToken: true,
      );
      if (response is BaseResponse) {
        final TermResponseModel termResponse = TermResponseModel(
          termList: TermModel.fromJsonList(
            response.results,
          ),
        );
        termModelList.addAll(termResponse.termList);
      }
    } finally {
      isAboutLoading(false);
    }
  }

  @override
  void onInit() {
    // fullNameFocusNode = FocusNode();
    // // jobDescriptionFocusNode = FocusNode();
    // phoneFocusNode = FocusNode();
    // passwordFocusNode = FocusNode();
    // cityFoCusNode = FocusNode();
    fetchCities();

    super.onInit();
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    emailController.dispose();
    lastNameFocusNode.dispose();
    jobNameFocusNode.dispose();
    jobNameController.dispose();
    lastNameController.dispose();
    fullNameFocusNode.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    jobDescriptionController.dispose();
    passwordController.dispose();
    cityController.dispose();
    super.dispose();
  }

  final List<String> ethiopianCities = [
    'Addis Ababa',
    'Dire Dawa',
    'Mekelle',
    'Gondar',
    'Hawassa',
    'Bahir Dar',
    'Jimma',
  ];

  void validateInputs({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String country,
    required String imageUrl,
    required String jobDescription,
  }) {
    if (fullName.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty ||
        country.isEmpty ||
        imageUrl.isEmpty ||
        jobDescription.isEmpty) {
      Get.snackbar(
        error.tr,
        pleaseFillAllThefield.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
