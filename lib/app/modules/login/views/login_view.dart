import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:with_helper/with_helper.dart';
import '../../../core/i18n/translation_keys.dart' as trs;
import '../../../core/widgets/pdf_viewer/circular_logo.dart';
import '../../signup/widgets/dropdown_city.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: WithHelper().withSpacing(
                spacing: 15.adaptSize,
                children: [
                  SizedBox(
                    height: 0.adaptSize,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.adaptSize),
                        child: LanguageDropdown(),
                      )),
                  SizedBox(height: 70.adaptSize),
                  const CircularLogo(),
                  Text(
                    'Log In',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 10.adaptSize),
                  Container(
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PhoneField(controller: controller),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.adaptSize),
                    height: 56.adaptSize,
                    child: Obx(
                      () => TextFormField(
                          style: Theme.of(context).textTheme.labelSmall,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.text,
                          focusNode: controller.passwordFocusNode,
                          obscureText:
                              controller.isPasswordVisible.value ? false : true,
                          decoration: InputDecoration(
                            hintText: trs.passwordPlaceholder.tr,
                            prefixIcon: Icon(
                              Icons.key,
                              color: const Color.fromARGB(89, 0, 0, 0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Obx(
                                () => IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                  ),
                                  onPressed: () =>
                                      controller.changePasswordVisibility(),
                                ),
                              ),
                            ),
                            suffixIconColor: const Color.fromARGB(89, 0, 0, 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.adaptSize)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black54)),
                          )),
                    ),
                  ),
                  SizedBox(height: 28.adaptSize),
                  InkWell(
                    onTap: () {
                      controller.doLogin(
                          phoneNumber: controller.phoneController.text,
                          password: controller.passwordController.text);
                    },
                    child: Container(
                      width: 250.adaptSize,
                      height: 44.adaptSize,
                      child: Center(
                          child: Obx(
                        () => controller.isLoading.value == true
                            ? SizedBox(
                                width: 20.adaptSize,
                                height: 20.adaptSize,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Log In',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                      )),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.adaptSize))),
                    ),
                  ),
                  SizedBox(height: 90.adaptSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        trs.donthaveAccount.tr,
                        textAlign: TextAlign.left,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.signup);
                          // Get.toNamed(Routes.language);
                        },
                        child: Text(
                          trs.register.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      showDropdownIcon: false,
      initialCountryCode: 'ET',
      disableLengthCheck: true,
      initialValue: '12-345-678',
      flagsButtonPadding: EdgeInsets.only(left: 5),
      style: Theme.of(context).textTheme.labelSmall,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.adaptSize)),
              borderSide: BorderSide(width: 1, color: Colors.black54)),
          hintText: trs.phoneNumber.tr),
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      focusNode: controller.phoneFocusNode,
      onSubmitted: (value) => controller.onSubmittedPhone(value, context),
    );
  }
}
