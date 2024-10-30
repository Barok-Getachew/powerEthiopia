import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/playing_screen_controller.dart';

class PlayingScreenView extends GetView<PlayingScreenController> {
  const PlayingScreenView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final param = Get.parameters['isOnlyPdf'] ?? false;
    debugPrint('indexisonlyPdf$param');
    bool isOnlyPdf = param == 'true';
    debugPrint('indexisonlyPdf$isOnlyPdf');

    return Obx(() => controller.isTrainingCategoryTrainingsLoading.isTrue
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                '${controller.courseList.isNotEmpty ? controller.courseList[0].title : ''}',
                style: theme.headlineSmall?.copyWith(
                    color: Colors.black,
                    overflow: TextOverflow.fade,
                    fontSize: 20),
              ),
            ),
            body: controller.courseList.isEmpty
                ? const Center(
                    child: Text('No Course Found'),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              '${controller.currentIndex.value + 1} / ${controller.courseList.length}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // if (!isOnlyPdf)

                      if (controller.courseList[controller.currentIndex.value]
                              .videoUrl!.isNotEmpty ==
                          true) ...[
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.width * 9.0 / 16.0,
                            child: Expanded(
                              child: WebViewWidget(
                                  controller: controller.webViewController),
                            )),
                        /*  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 9.0 / 16.0,
                    child:
                        Video(controller: VideoController(controller.player)),
                  ), */
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: 5.h,
                            maxHeight: 15.h,
                          ),
                          decoration:
                              const BoxDecoration(color: Color(0xFF707070)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 312,
                                  child: Text(
                                      controller
                                              .courseList[
                                                  controller.currentIndex.value]
                                              .subTitle ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            minWidth: MediaQuery.of(context).size.width * 0.9),
                        child: Obx(() => Column(
                              children: [
                                SizedBox(
                                  height: controller
                                              .courseList[
                                                  controller.currentIndex.value]
                                              .videoUrl!
                                              .isNotEmpty ==
                                          true
                                      ? 40.h
                                      : 70.h,
                                  child: SfPdfViewer.network(
                                    "${ApiConstant.baseImageUrl}${controller.courseList[controller.currentIndex.value].pdfUrl}",
                                    // "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"
                                    canShowPageLoadingIndicator: true,
                                    canShowScrollStatus: false,
                                    pageSpacing: 0,
                                    controller: controller.pdfController,
                                    onDocumentLoadFailed:
                                        (PdfDocumentLoadFailedDetails details) {
                                      print(details.error);
                                    },
                                  ),
                                )
                                // PdfViewerWidget(
                                //   height: isOnlyPdf ? 80 : 40,
                                //   url: controller
                                //           .courseList[controller.currentIndex.value]
                                //           .pdfUrl ??
                                //       controller.url,
                                // )
                                // Text(controller.textValue,
                                //     textAlign: TextAlign.center,
                                //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                //           color: Colors.black,
                                //           fontSize: 12,
                                //           fontWeight: FontWeight.w400,
                                //         )),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: controller.currentIndex.value == 0
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          if (controller.currentIndex.value != 0)
                            TextButton(
                              onPressed: () {
                                controller.prevVideo();
                                // controller.currentIndex.value--;
                              },
                              child: Text('Previous',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: const Color(0xFF1C4588),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      )),
                            ),
                          if (controller.currentIndex.value !=
                              controller.courseList.length - 1)
                            TextButton(
                              onPressed: () {
                                debugPrint(
                                    'index${controller.currentIndex.value}');
                                controller.nextVideo();
                                // controller.closePlayer();

                                // Get.toNamed(Routes.secondAboutusOnboarding);
                              },
                              child: Text('Next',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: const Color(0xFF1C4588),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      )),
                            ),
                        ],
                      )
                    ],
                  )));
  }
}
