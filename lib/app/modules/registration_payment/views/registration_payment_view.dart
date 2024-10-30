import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/constants/constants.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/modules/registration_payment/widgets/banklist_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:with_helper/with_helper.dart';

import '../../../core/i18n/translation_keys.dart' as trs;
import '../controllers/registration_payment_controller.dart';

class RegistrationPaymentView extends GetView<RegistrationPaymentController> {
  const RegistrationPaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final param = Get.parameters['userId'] ?? 0;
    debugPrint("param$param");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          trs.registerForPowerEthiopia.tr,
          style: theme.headlineSmall?.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: WithHelper().withSpacing(
              spacing: 16,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 45.h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFE2E1E5)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Obx(() => controller.isBankLoading.isTrue
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.bankList.length,
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GetBuilder<RegistrationPaymentController>(
                                  id: "bank",
                                  builder: (controller) => BankListWidget(
                                    bankInfoId: controller.bankList[index].id,
                                    selectedBankInfoId:
                                        controller.selectedBankInfoId.value,
                                    onTap: () => controller.onTapBankInfo(
                                        controller.bankList[index]),
                                    accountNumber: controller
                                        .bankList[index].accountNumber,
                                    name: controller.bankList[index].name,
                                    imageUrl:
                                        "${ApiConstant.baseImageUrl}${controller.bankList[index].imageUrl}",
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ))),
                SizedBox(
                  width: 295,
                  child: Text(
                    sendScreenshotCheckOut.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.selectPicture();

                      // Navigate to the signup view
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: Text(
                      trs.uploadScreenshot.tr,
                      style: theme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Obx(() => SizedBox(
                      width: 295,
                      child: Text(
                        controller.fileNameObs.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    )),

                SizedBox(
                  height: 55,
                  child: Obx(() => ElevatedButton(
                        onPressed: () {
                          controller.doVerifyPayment(
                              userId: param
                                  .toString()); // Navigate to the signup view
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        child: controller.isLoading.value == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                trs.finishPayment.tr,
                                style: theme.bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Frame2418(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
