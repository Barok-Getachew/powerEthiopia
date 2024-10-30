import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/constants/constants.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';

import 'package:ethiosolar_app/app/data/models/address/delivery_address_model.dart';
import 'package:ethiosolar_app/app/data/models/checkout/checkout_request_model.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/modules/registration_payment/widgets/banklist_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:with_helper/with_helper.dart';

import '../../../core/i18n/translation_keys.dart' as trs;
import '../controllers/check_out_screen_controller.dart';

class CheckOutScreenView extends GetView<CheckOutScreenController> {
  const CheckOutScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    CheckoutRequestModel checkoutRequest = Get.arguments;
    debugPrint('checkoutRequest ${checkoutRequest.toJson()}');
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          checkOut.tr,
          style: theme.headlineSmall?.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: WithHelper().withSpacing(
              spacing: 16,
              children: [
                const SizedBox(
                  height: 20,
                ),
                buildSubTotalWidget(
                    Amount: checkoutRequest.totalPrice.toString()),
                Obx(
                  () => controller
                          .deliveryAddressController.isLoadingAddress.isTrue
                      ? const SizedBox.shrink()
                      : _buildAdressDropDown(controller: controller),
                ),
                Container(
                    height: 300.h,
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
                                GetBuilder<CheckOutScreenController>(
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
                  child: Text(
                    sendScreenshotCheckOut.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        controller
                            .doVerifyPayment(); // Navigate to the signup view
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
                    ),
                  ),
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

class _buildAdressDropDown extends StatelessWidget {
  const _buildAdressDropDown({
    required this.controller,
  });

  final CheckOutScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<DeliveryAddressModel>(
          borderRadius: BorderRadius.circular(10),
          decoration: InputDecoration(
            counterStyle: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            labelStyle: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            hintStyle: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF707070),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF707070),
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF707070),
                )), // This adds the border
          ),
          isExpanded: true,
          iconSize: 30,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(
            color: Colors.black,
          ),
          items: controller.deliveryAddressController.deliveryAddress
              .map<DropdownMenuItem<DeliveryAddressModel>>(
                  (DeliveryAddressModel value) {
            return DropdownMenuItem<DeliveryAddressModel>(
              value: value,
              child: Text(
                value.address ?? "",
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            );
          }).toList(),
          onChanged: (DeliveryAddressModel? newValue) {
            // Do something with the selected value
            controller.selectedDeliveryAddress = newValue!;
          },
          hint: Text(selectAddress.tr),
        ),
        controller.deliveryAddressController.deliveryAddress.isEmpty
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox.shrink(),
        controller.deliveryAddressController.deliveryAddress.isEmpty
            ? ElevatedButton(
                onPressed: () => controller.onTapAddDeliveryAddress(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: controller.isLoading.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        addDeliveryAddress.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class buildSubTotalWidget extends StatelessWidget {
  final String Amount;
  const buildSubTotalWidget({
    super.key,
    required this.Amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF707070),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '$total:',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Amount,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'ETB',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
