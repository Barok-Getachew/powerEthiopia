import 'package:ethiosolar_app/app/core/extensions/validators.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';

import 'package:ethiosolar_app/app/core/widgets/appbar/custom_app_bar.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_leading_image.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_title.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/input_fields/custom_text_form_field.dart';
import 'package:ethiosolar_app/app/data/models/city/city_model.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/update_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: _buildAppBar(context),
        body: controller.isCityLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fullName.tr,
                              style: theme.bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                          SizedBox(height: 9.v),
                          CustomTextFormField(
                            focusNode: controller.fullNameFocusNode,
                            controller: controller.fullNameController,
                            validator: (value) => value
                                .toString()
                                .validateField(fieldName: fullName.tr),
                          ),
                          SizedBox(height: 15.v),
                          Text(phoneNumber.tr,
                              style: theme.bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                          SizedBox(height: 9.v),
                          CustomTextFormField(
                            focusNode: controller.phoneNumberFocusNode,
                            controller: controller.phoneNumberController,
                            validator: (value) => value
                                .toString()
                                .validateField(fieldName: phoneNumber.tr),
                          ),
                          SizedBox(height: 9.v),
                          Text(password.tr,
                              style: theme.bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                          SizedBox(height: 9.v),
                          CustomTextFormField(
                            focusNode: controller.passwordFocusNode,
                            controller: controller.passwordController,
                            // validator: (value) => value
                            //     .toString()
                            //     .validateField(fieldName: password.tr),
                          ),
                          SizedBox(height: 16.v),
                          Text(jobName.tr,
                              style: theme.bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            focusNode: controller.addressFocusNode,
                            controller: controller.jobDescriptionController,
                            validator: (value) => value
                                .toString()
                                .validateField(fieldName: deliveryAddress.tr),
                          ),
                          SizedBox(height: 16.v),
                          Text(city.tr,
                              style: theme.bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                          SizedBox(height: 8.v),
                          TypeAheadField<CityModel>(
                            loadingBuilder: (BuildContext context) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              );
                            },
                            controller: controller.cityController,
                            suggestionsCallback: (search) {
                              return controller.cities.where((product) {
                                final nameLower = product.name
                                        ?.toLowerCase()
                                        .split(' ')
                                        .join('') ??
                                    '';
                                final patternLower =
                                    search.toLowerCase().split(' ').join('');
                                return nameLower.contains(patternLower);
                              }).toList();
                            }, //CityService.of(context).find(search),
                            builder: (context, controller, focusNode) {
                              return CustomTextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                autofocus: true,
                                // decoration: InputDecoration(
                                //   border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10),
                                //     borderSide: const BorderSide(
                                //         color: Color(
                                //             0xFFE2E1E5) //Colors.grey.shade100,
                                //         ),
                                //   ),
                                // labelText: 'City',
                              );
                            },
                            itemBuilder: (context, city) {
                              return ListTile(
                                title: Text(city.name!),
                                // subtitle: Text(city.country),
                              );
                            },
                            onSelected: (city) {
                              controller.cityController.text =
                                  city.name.toString();
                              controller.selectedCity.value =
                                  city.name.toString();
                              debugPrint(
                                  "selected ${controller.selectedCity.value}");
                            },
                          ),
                          SizedBox(height: 8.v),
                          /* CustomTextFormField(
                      controller: controller.cityController,
                      validator: (value) =>
                          value.toString().validateField(fieldName: "City"),
                    ),
                    SizedBox(height: 16.v),
                    Text(jobDescription.tr,
                        style: theme.bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                    SizedBox(height: 8.v),
                    CustomTextFormField(
                      controller: controller.salespersonController,
                      validator: (value) => value
                          .toString()
                          .validateField(fieldName: jobDescription.tr),
                    ), */
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
                          SizedBox(height: 12.v),
                          _buildBrowseFiles(context),
                          SizedBox(height: 5.v)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: _buildUpdateInformation(context));
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
            Navigator.pop(context);
          },
        ),
        title: AppbarTitle(
            text: updateInformation.tr, margin: EdgeInsets.only(left: 33.h)));
  }

  /// Section Widget
  Widget _buildAddress(BuildContext context) {
    return CustomTextFormField(
      controller: controller.jobDescriptionController,
    );
  }

  /// Section Widget
  Widget _buildCity(BuildContext context) {
    return CustomTextFormField(controller: controller.cityController);
  }

  /// Section Widget
  Widget _buildSalesperson(BuildContext context) {
    return CustomTextFormField(
        controller: controller.salespersonController,
        hintText: "Sales person",
        textInputAction: TextInputAction.done);
  }

  /// Section Widget
  Widget _buildBrowseFiles(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CustomElevatedButton(
      height: 38.v,
      text: browseFiles.tr,
      buttonTextStyle: theme.bodyMedium!.copyWith(color: Colors.white),
      onPressed: () => controller.selectImage(),
    );
  }

  /// Section Widget
  Widget _buildUpdateInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
          onPressed: () {
            controller.updateProfile();
          },
          child: Obx(
            () => controller.isUpdateProfileLoading.value == true
                ? const CircularProgressIndicator()
                : Text(
                    updateInformation.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
          )),
    );
  }

  /// Navigates to the profileContainerScreen when the action is triggered.
  onTapUpdateInformation(BuildContext context) {
    controller.updateProfile();
  }
}
