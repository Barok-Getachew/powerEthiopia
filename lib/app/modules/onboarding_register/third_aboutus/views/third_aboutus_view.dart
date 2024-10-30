import 'package:ethiosolar_app/app/core/utils/constants/constants.dart';
import 'package:ethiosolar_app/app/core/widgets/pdf_viewer/pdfViewer.dart';
import 'package:ethiosolar_app/app/modules/onboarding_register/third_aboutus/controllers/third_aboutus_controller.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ThirdAboutusView extends GetView<ThirdAboutusController> {
  const ThirdAboutusView({super.key});
  @override
  Widget build(BuildContext context) {
    String url =
        "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf";

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
              child: Text('About Training',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            YoutubePlayer(
              controller: controller.controller,
              aspectRatio: 16 / 9,
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
                  SizedBox(
                      width: 312,
                      child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur lorem libero, molestie vitae pharetra cursus, faucibus sit amet arcu.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
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
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PdfViewerWidget(
                      height: 60,
                      url: url,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.secondAboutusOnboarding);
                  },
                  child: Text('Previous',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF1C4588),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          )),
                ),
                TextButton(
                  onPressed: () {
                    controller.closePlayer();
                    Get.toNamed(Routes.signup);
                  },
                  child: Text('Next',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF1C4588),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          )),
                ),
              ],
            )
          ],
        ));
  }
}
