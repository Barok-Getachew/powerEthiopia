import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ethiosolar_app/app/core/extensions/validators.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/custom_app_bar.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_leading_image.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_title.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/input_fields/custom_text_form_field.dart';

import '../controllers/credit_form_view_controller.dart';

class CreditFormViewView extends GetView<CreditFormViewController> {
  final userProfileController = Get.find<ProfileScreenController>();
  CreditFormViewView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    // // final param = Get.parameters['isCommercial'] ?? false;
    // debugPrint('isCommercial$param');
    // bool isCommercial = param == 'true';
    // debugPrint('isCommercial$isCommercial');
    return Scaffold(
      // resizeToAvoidBottomInset: t,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 28.v),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 315,
                      child: Text(
                        creditDesc.tr,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )),
                ),
                SizedBox(height: 9.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(fullName.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                SizedBox(height: 9.v),
                // _buildFullName(context),
                GetBuilder<ProfileScreenController>(
                    builder: (userProfileController) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 18),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(10)),
                    child:
                        Text("${userProfileController.userModel!.fullName!}"),
                  );
                }),
                SizedBox(height: 15.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(phoneNumber.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                SizedBox(height: 9.v),
                GetBuilder<ProfileScreenController>(
                    builder: (userProfileController) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 18),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                        "${userProfileController.userModel!.phoneNumber!}"),
                  );
                }),
                SizedBox(height: 16.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(fieldOfBusiness.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                SizedBox(height: 9.v),
                _buildFieldOfBusiness(context),
                SizedBox(height: 16.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(tradeName.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                SizedBox(height: 9.v),
                _buildTradeName(context),
                SizedBox(height: 16.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(locationAddress.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                SizedBox(height: 8.v),
                GetBuilder<ProfileScreenController>(
                    builder: (userProfileController) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 18),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("${userProfileController.userModel!.country!}"),
                  );
                }),
                SizedBox(height: 16.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(creditAmount.tr,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                SizedBox(height: 9.v),
                _buildCreditAmount(context),
                SizedBox(height: 16.v),
                SizedBox(height: 14.v),
                Container(
                    width: 295.h,
                    margin: EdgeInsets.only(left: 10.h, right: 9.h),
                    child: Text(pleaseUpload.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.bodyMedium!
                            .copyWith(color: Colors.grey[600]))),
                Obx(() {
                  if (controller.selectedImageObs!.value.path.isNotEmpty) {
                    return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            Get.to(PhotoView(
                              imageProvider:
                                  FileImage(controller.selectedImageObs!.value),
                            ));
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child:
                                Image.file(controller.selectedImageObs!.value),
                          ),
                        )
                        // Show an empty container when the list is empty
                        );
                  }
                  return Container();
                }),
                /* controller.selectedImageObs == null
                    ? const Text('No image selected.')
                    : SizedBox(
                        height: 50,
                        width: 50,
                        child: InkWell(
                            onTap: () {
                              Get.to(PhotoView(
                                imageProvider:
                                    FileImage(controller.selectedImageObs!.value),
                              ));
                            },
                            child:
                                Image.file(controller.selectedImageObs!.value))),
                */
                SizedBox(height: 12.v),
                _buildBrowseFiles(context),
                SizedBox(height: 5.v)
              ]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildUpdateInformation(context),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 45.v,
        leadingWidth: 64.h,
        leading: AppbarLeadingImage(
          imagePath: 'assets/images/img_arrow_down.svg',
          margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
          onTap: () {
            FocusScope.of(context).focusedChild?.unfocus();

            Get.back();
          },
        ),
        title: AppbarTitle(text: applyForCredit.tr));
  }

  /// Section Widget
  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
      focusNode: controller.fullNameFocusNode,
      controller: controller.fullNameController,
      validator: (value) =>
          value.toString().validateField(fieldName: "Full Name"),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
      focusNode: controller.phoneNumberFocusNode,
      controller: controller.phoneNumberController,
      validator: (value) =>
          value.toString().validateField(fieldName: "Phone Number"),
    );
  }

  /// Section Widget
  Widget _buildAddress(BuildContext context) {
    return CustomTextFormField(
      focusNode: controller.addressFocusNode,
      controller: controller.addressController,
      validator: (value) =>
          value.toString().validateField(fieldName: "Address"),
    );
  }

  Widget _buildCreditAmount(BuildContext context) {
    return CustomTextFormField(
      focusNode: controller.creditAmountFocusNode,
      textInputType: TextInputType.number,
      controller: controller.creditAmountController,
      validator: (value) =>
          value.toString().validateField(fieldName: "Credit amount"),
    );
  }

  Widget _buildFieldOfBusiness(BuildContext context) {
    return CustomTextFormField(
      focusNode: controller.fieldOfBusinessFocusNode,
      textInputType: TextInputType.text,
      controller: controller.fieldOfBusinessController,
      // validator: (value) =>
      //     value.toString().validateField(fieldName: "Field of business"),
    );
  }

  Widget _buildTradeName(BuildContext context) {
    return CustomTextFormField(
      focusNode: controller.tradeNameFocusNode,
      textInputType: TextInputType.text,
      controller: controller.tradeNameController,
      // validator: (value) =>
      //     value.toString().validateField(fieldName: "Trade name"),
    );
  }

  /// Section Widget

  /// Section Widget
  Widget _buildBrowseFiles(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CustomElevatedButton(
      height: 38.v,
      text: browseFiles.tr,
      buttonTextStyle: theme.bodyMedium!.copyWith(color: Colors.white),
      onPressed: () => controller.selectPicture(),
    );
  }

  /// Section Widget
  Widget _buildUpdateInformation(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Obx(
      () => CustomElevatedButton(
        text: applyForCredit.tr,
        margin: EdgeInsets.only(left: 10.h, right: 10.h, bottom: 42.v),
        buttonTextStyle: theme.bodyMedium!.copyWith(color: Colors.white),
        height: 45.v,
        child: controller.isApplyingCreditLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : null,
        onPressed: () => controller.applyForCredit(),
      ),
    );
  }

  /// Navigates to the profileContainerScreen when the action is triggered.
  onTapUpdateInformation(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.profileContainerScreen);
  }
}
