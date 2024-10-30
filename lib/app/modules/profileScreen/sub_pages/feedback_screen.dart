// ignore_for_file: must_be_immutable

import 'package:ethiosolar_app/app/core/extensions/validators.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/core/widgets/input_fields/custom_text_form_field.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackScreen extends GetView<ProfileScreenController> {
  FeedbackScreen({super.key});

  TextEditingController customerFeedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.h),
            topRight: Radius.circular(20.h),
          ),
        ),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 30.h,
          vertical: 10.v,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            CustomImageView(
              imagePath: 'assets/images/img_line_4.svg',
              height: 5.v,
              width: 40.h,
            ),
            SizedBox(height: 14.v),
            Text(customerFeedback.tr,
                style: theme.bodyLarge!.copyWith(color: Colors.grey[600])),
            SizedBox(height: 5.v),
            Divider(
              thickness: 0.5.h,
            ),
            SizedBox(height: 19.v),
            Form(
              key: controller.formKey,
              child: CustomTextFormField(
                controller: customerFeedbackController,
                hintText: weWouldLoveTohear.tr,
                hintStyle: theme.bodyMedium!.copyWith(color: Colors.grey[400]),
                textInputAction: TextInputAction.done,
                maxLines: 5,
                validator: (value) =>
                    value.toString().validateField(fieldName: "Feedback"),
              ),
            ),
            SizedBox(height: 10.v),
            _buildSendFeedbackButton(context)
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSendFeedbackButton(BuildContext context) {
    return Obx(
      () => CustomElevatedButton(
        height: 38.v,
        width: 257.h,
        text: sendFeedback.tr,
        margin: EdgeInsets.symmetric(
          horizontal: 59.h,
        ),
        buttonTextStyle: theme.textTheme.titleSmall!,
        child: controller.isAddFeedbackLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : null,
        onPressed: () =>
            controller.addFeedback(customerFeedbackController.text),
      ),
    );
  }
}
