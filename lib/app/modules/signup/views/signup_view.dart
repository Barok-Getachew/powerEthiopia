import 'package:ethiosolar_app/app/core/exports/app_exports.dart';

import 'package:ethiosolar_app/app/modules/login/widget/phone_field.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/translation_keys.dart' as trs;

import '../../../core/i18n/translation_keys.dart';
import '../../../core/widgets/pdf_viewer/circular_logo.dart';

import '../../../core/widgets/pdf_viewer/pdfViewer.dart';
import '../../../data/services/api_constant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';
import '../widgets/dropdown_city.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  List<Step> buildSteps(BuildContext context) {
    return [
      Step(
        title: Text(
          'Basic Info',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        isActive: controller.activeStep.value >= 0,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 56.adaptSize,
                    child: FormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "*required";
                        }
                        return null;
                      },
                      focusNode: controller.fullNameFocusNode,
                      nextFocusNode: controller.lastNameFocusNode,
                      iconData: Icons.person,
                      editingController: controller.fullNameController,
                      controller: controller,
                      labelText: trs.trFirstName.tr,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.adaptSize),
                    height: 56.adaptSize,
                    child: FormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "*required";
                        }
                        return null;
                      },
                      focusNode: controller.lastNameFocusNode,
                      nextFocusNode: controller.passwordFocusNode,
                      iconData: Icons.person,
                      editingController: controller.lastNameController,
                      controller: controller,
                      labelText: trs.trLastName.tr,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 56,
              width: double.infinity,
              child: PhoneField(
                controller: controller,
                phoneFocusNode: controller.phoneFocusNode,
                nextFocusNode: controller.passwordFocusNode,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 56.adaptSize,
              child: Obx(
                () => TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: controller.passwordController,
                    keyboardType: TextInputType.text,
                    focusNode: controller.passwordFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context)
                          .requestFocus(controller.confirmPasswordFocusNode);
                    },
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.adaptSize)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54)),
                    )),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 56.adaptSize,
              child: Obx(
                () => TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: controller.confirmPasswordController,
                    keyboardType: TextInputType.text,
                    focusNode: controller.confirmPasswordFocusNode,
                    obscureText: controller.isConfirmPasswordVisible.value
                        ? false
                        : true,
                    decoration: InputDecoration(
                      hintText: trs.trConfirmPassword.tr,
                      prefixIcon: Icon(
                        Icons.key,
                        color: const Color.fromARGB(89, 0, 0, 0),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Obx(
                          () => IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                            ),
                            onPressed: () =>
                                controller.changeConfirmPasswordVisibility(),
                          ),
                        ),
                      ),
                      suffixIconColor: const Color.fromARGB(89, 0, 0, 0),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.adaptSize)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54)),
                    )),
              ),
            ),
          ],
        ),
      ),
      Step(
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        isActive: controller.activeStep.value >= 1,
        content: Container(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 56.adaptSize,
                child: FormField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "*required";
                    }
                    return null;
                  },
                  focusNode: controller.emailFocusNode,
                  nextFocusNode: controller.cityFoCusNod,
                  iconData: Icons.email,
                  editingController: controller.emailController,
                  controller: controller,
                  labelText: trs.Email.tr,
                ),
              ),
              Container(
                height: 56.adaptSize,
                child: FormField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "*required";
                    }
                    return null;
                  },
                  focusNode: controller.cityFoCusNod,
                  nextFocusNode: controller.jobNameFocusNode,
                  iconData: Icons.location_city,
                  editingController: controller.cityController,
                  controller: controller,
                  labelText: trs.city.tr,
                ),
              ),
              Container(
                height: 56.adaptSize,
                child: FormField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "*required";
                    }
                    return null;
                  },
                  focusNode: controller.jobNameFocusNode,
                  iconData: Icons.work,
                  editingController: controller.jobNameController,
                  controller: controller,
                  labelText: trs.jobName.tr,
                ),
              ),
              ImageUploadField(controller: controller),
              SizedBox(
                height: 10.adaptSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isChecked.value,
                      onChanged: (value) => controller.toggle(),
                    ),
                  ),
                  Obx(() => InkWell(
                        onTap: () async {
                          await controller.getTerm();

                          if (controller.termModelList.isNotEmpty) {
                            Get.to(PdfViewerWidget(
                              height: MediaQuery.of(context).size.height * 0.8,
                              url:
                                  "${ApiConstant.baseImageUrl}${controller.termModelList[0].pdfUrl}" ??
                                      '',
                            ));
                          }
                        },
                        child: SizedBox(
                          child: Text(
                            controller.isAboutLoading.isTrue
                                ? "loading"
                                : agreeTermsAndCondi.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text(
          'Register',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        isActive: controller.activeStep.value >= 2,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              height: 56,
              width: double.infinity,
              child: PhoneField(
                controller: controller,
                phoneFocusNode: controller.phoneFocusNode,
                nextFocusNode: controller.passwordFocusNode,
              ),
            ),
          ],
        ),
      )
    ];
  }

  Widget build(BuildContext context) {
    var appBar = AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      actions: [
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.adaptSize),
              child: LanguageDropdown(),
            )),
      ],
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.adaptSize,
          ),
          SizedBox(height: 10.adaptSize),
          const CircularLogo(),
          Center(
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(height: 6.adaptSize),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.v),
        child: appBar,
      ),
      body: Stack(
        children: [
          Obx(
            () => Form(
              key: controller.formKey,
              child: Stepper(
                elevation: 0,
                currentStep: controller.activeStep.value,
                type: StepperType.horizontal,
                onStepContinue: () {
                  controller.formKey.currentState!.validate();

                  if (controller.isStepCompleted()) {
                    if (controller.activeStep.value ==
                        buildSteps(context).length - 1) {
                      print('send to server');
                      print(controller.activeStep.value);
                    } else {
                      controller.activeStep.value++;
                    }
                  }
                },
                onStepCancel: () {
                  controller.activeStep.value == 0
                      ? null
                      : controller.activeStep.value--;
                },
                steps: buildSteps(context),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.adaptSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 140.adaptSize,
                          height: 42.adaptSize,
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary, // Custom background color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              controller.activeStep.value ==
                                      buildSteps(context).length - 1
                                  ? trs.finishPayment.tr
                                  : trs.continuee.tr,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: details.onStepCancel,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface), // Custom border color
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 18.adaptSize),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 80,
            bottom: 20,
            child: Row(
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
                    Get.toNamed(Routes.login);
                    // Get.toNamed(Routes.language);
                  },
                  child: Text(
                    trs.login.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.editingController,
    required this.iconData,
    required this.focusNode,
    this.nextFocusNode,
    required this.validator,
  });

  final SignupController controller;
  final String labelText;
  final TextEditingController editingController;
  final IconData iconData;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        style: Theme.of(context).textTheme.bodyMedium,
        controller: editingController,
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            size: 18,
            color: const Color.fromARGB(78, 0, 0, 0),
          ),
          hintText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.adaptSize)),
              borderSide: BorderSide(width: 1)),
        ));
  }
}

class ImageUploadField extends StatelessWidget {
  final controller;

  const ImageUploadField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: controller.selectedMultipleImagesObs.isNotEmpty ? 70 : 0,
            child: controller.selectedMultipleImagesObs.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.selectedMultipleImagesObs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            InkWell(
                              onTap: () {
                                // Implement image preview if needed
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  controller.selectedMultipleImagesObs[index]!,
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 60,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 6,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  controller.selectedMultipleImagesObs
                                      .removeAt(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          );
        }),
        const SizedBox(
            height: 8), // Add spacing between the image list and button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SizedBox(
            height: 45, // Fixed height for the button
            child: Obx(
              () => SizedBox(
                height: 44,
                child: TextButton(
                  onPressed: () async {
                    // Show a dialog to select camera or gallery
                    final choice = await _showImageSourceSelection(context);
                    if (choice != null) {
                      if (choice == 'camera') {
                        await controller.selectPictureFromCamera();
                      } else if (choice == 'gallery') {
                        await controller.selectMultiplePicture();
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.black54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(134, 183, 183, 183),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.upload_file, color: Colors.grey[600]),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          controller.selectedMultipleImagesObs.isNotEmpty
                              ? 'Selected: ${controller.selectedMultipleImagesObs[0]!.path.split('/').last}'
                              : 'Please upload', // Use your localization here
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _showImageSourceSelection(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Camera'),
                onTap: () => Navigator.of(context).pop('camera'),
              ),
              ListTile(
                title: Text('Gallery'),
                onTap: () => Navigator.of(context).pop('gallery'),
              ),
            ],
          ),
        );
      },
    );
  }
}
