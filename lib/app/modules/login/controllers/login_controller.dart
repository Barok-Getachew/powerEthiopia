import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/data/models/login_model.dart';
import 'package:ethiosolar_app/app/data/models/user/user_process_model.dart';
import 'package:ethiosolar_app/app/data/services/api_client.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/data/services/api_response.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../core/utils/store/user_session.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  late FocusNode phoneFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void onInit() {
    phoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.onInit();
  }

  // this function is used to focus to the next input field
  void onSubmittedPhone(String? value, BuildContext context) {
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  Map<String, dynamic> getLoginReq(
      {required String phoneNumber, required String password}) {
    LoginReq req = LoginReq(phoneNumber: phoneNumber, password: password);
    return req.toJson();
  }

  Future<void> doLogin(
      {required String phoneNumber, required String password}) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      Get.snackbar(error.tr, pleaseFillAllThefield.tr);
    } else if (phoneNumber.length != 9) {
      Get.snackbar(error, pleaseEnterValidPhoneNumber.tr);
    } else if (password.length < 6) {
      Get.snackbar(error.tr, passwordMust.tr);
    } else {
      try {
        isLoading.value = true;
        Map<String, dynamic> params =
            getLoginReq(phoneNumber: phoneNumber, password: password);

        ApiResponse? response = await ApiClient.instance.call(
          method: ApiMethod.POST,
          params: params,
          token: '',
          endPoint: ApiConstant.kloginApi,
        );
        if (response is BaseResponse) {
          debugPrint('here');
          if (response.results is Map &&
              response.results.containsKey('token')) {
            UserModel loginData = UserModel.fromJson(response.results);
            debugPrint('is user valid ${loginData.id}');

            await UserSession.setUserToken(loginData.token);
            await UserSession.setUserData(loginData);
            Get.offAllNamed(Routes.home);
          } else {
            UserProcessModel user = UserProcessModel.fromJson(response.results);
            Get.offAllNamed(Routes.registrationPayment,
                parameters: {'userId': user.userId.toString()});
          }
        } else if (response is ErrorResponse) {
          Get.snackbar(
            'Error',
            response.errorMessage.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );

          // Get.snackbar('Error', 'Something went wrong');
          debugPrint('login failed');
        }

        isLoading.value = false;
      } catch (e) {
        Get.snackbar('Error', 'Something went wrong');

        isLoading.value = false;

        debugPrint('login failed');
        debugPrint(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Future<void> login(String email, String password) async {
  //   var response = await ApiClient.instance.call(
  //       endPoint: 'auth/login',
  //       method: ApiMethod.POST,
  //       params: {'email': email, 'password': password});

  //   if (response.status == 'success') {
  //     // login successful
  //     // store token, user info etc
  //     await Get.offNamed('/home');
  //   } else {
  //     // login failed
  //     // show error
  //   }
  // }

  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
