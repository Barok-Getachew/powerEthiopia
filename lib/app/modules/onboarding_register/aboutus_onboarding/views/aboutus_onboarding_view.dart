import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/constants/constants.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/aboutus_onboarding_controller.dart';

class AboutusOnboardingView extends GetView<AboutusOnboardingController> {
  const AboutusOnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 316,
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.75),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE2E1E5)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Obx(() => Text(
                  controller.onBoadingList.isEmpty
                      ? ''
                      : controller
                          .onBoadingList[controller.currentIndex.value].title
                          .toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ))),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 9.0 / 16.0,
              child: Video(controller: VideoController(controller.player)),
            ),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 80,
                maxHeight: 200,
              ),
              decoration: const BoxDecoration(color: Color(0xFF707070)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => controller.isOnBoardingLLoading.value ||
                          controller.onBoadingList.isEmpty
                      ? const SizedBox(height: 1, width: 1)
                      : SizedBox(
                          width: 312,
                          child: Text(
                              controller
                                      .onBoadingList[
                                          controller.currentIndex.value]
                                      .subTitle
                                      .toString() ??
                                  '',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )))),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Text(controller.onBoadingList[controller.currentIndex.value]
            //                 .
            //                 .toString() ==
            //             ""),
            Obx(() => controller.isOnBoardingLLoading.value ||
                    controller.onBoadingList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primaryColor,
                  ))
                : Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                        minWidth: MediaQuery.of(context).size.width * 0.9),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Obx(() {
                          debugPrint(
                              "currentIndex${controller.currentIndex.value}");
                          return ValueListenableBuilder(
                              valueListenable:
                                  ValueNotifier(controller.currentIndex.value),
                              builder: (context, value, child) {
                                return SizedBox(
                                    height: 35.h,
                                    child: SfPdfViewer.network(
                                      "${ApiConstant.baseImageUrl}${controller.onBoadingList[controller.currentIndex.value].pdfUrl}",
                                      // "${ApiConstant.baseImageUrl}${controller.onBoadingList[controller.currentIndex.value].pdfUrl}",
                                      // "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"
                                      canShowPageLoadingIndicator: true,
                                      canShowScrollStatus: false,
                                      pageSpacing: 0,
                                      controller: controller.pdfController,
                                      onDocumentLoadFailed:
                                          (PdfDocumentLoadFailedDetails
                                              details) {
                                        print(details.error);
                                      },
                                    ));
                              });
                        }),
                      ],
                    )),
                  )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.isOnBoardingLLoading.value
                ? const SizedBox(height: 1, width: 1)
                : Row(
                    mainAxisAlignment: controller.currentIndex.value == 0
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.currentIndex.value == 1 ||
                          controller.currentIndex.value == 2)
                        TextButton(
                          onPressed: () {
                            controller.prevVideo();
                          },
                          child: Text(previous.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: const Color(0xFF1C4588),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                        ),
                      TextButton(
                        onPressed: () {
                          if (controller.currentIndex.value !=
                              controller.onBoadingList.length - 1) {
                            debugPrint('still on the if');
                            controller.nextVideo();
                            debugPrint(
                                'value is ${controller.currentIndex} and length is ${controller.onBoadingList.length}');
                          } else {
                            controller.closePlayer();
                            debugPrint('what is the problem');
                            Get.toNamed(Routes.signup);
                          }
                        },
                        child: Text(next.tr,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFF1C4588),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    )),
                      ),
                    ],
                  ))
          ],
        ));
  }
}
