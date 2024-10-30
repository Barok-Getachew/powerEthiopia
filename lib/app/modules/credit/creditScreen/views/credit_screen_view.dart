import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';

import '../controllers/credit_screen_controller.dart';

class CreditScreenView extends GetView<CreditScreenController> {
  const CreditScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 75.v),
          Center(
            child: CustomImageView(
              imagePath: 'assets/images/img_ellipse_7.png',
              height: 75.adaptSize,
              width: 75.adaptSize,
              radius: BorderRadius.circular(37.h),
            ),
          ),
          Obx(() => controller.isCreditLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CreditWidget(
                    imageUrl: controller.creditList[index].imageUrl ?? "",
                    title: controller.creditList[index].title ?? "",
                    onTap: () {
                      Get.toNamed(
                        Routes.creditFormView,
                        arguments: controller.creditList[index].id.toString(),
                        parameters: {
                          "isCommercial":
                              controller.creditList[index].creditType ==
                                      "Commercial"
                                  ? "true"
                                  : "false",
                          "creditType":
                              controller.creditList[index].creditType ?? ""
                        },
                      );
                    },
                    description: controller.creditList[index].description ?? "",
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: controller.creditList.length,
                )),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 30.h),
      //     child: Column(
      //       children: [
      //         SizedBox(height: 25.v),
      //         CustomImageView(
      //             imagePath: 'assets/images/img_ellipse_7.png',
      //             height: 75.adaptSize,
      //             width: 75.adaptSize,
      //             radius: BorderRadius.circular(37.h)),
      //         SizedBox(height: 30.v),
      //         SizedBox(height: 30.v),
      //         CreditWidget(
      //           title: 'A+ Credit Service (Group)',
      //           onTap: () {
      //             Get.toNamed(Routes.creditFormView);
      //           },
      //           description:
      //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      //         ),
      //         SizedBox(height: 30.v),
      //         CreditWidget(
      //           title: 'A+ Credit Service (Commercial)',
      //           onTap: () {
      //             Get.toNamed(Routes.creditFormView,
      //                 parameters: {'isCommercial': 'true'});
      //           },
      //           description:
      //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class CreditWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final String imageUrl;
  const CreditWidget({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.adaptSize,
      height: 157.adaptSize,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFE2E1E5),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 75.adaptSize,
                  height: 75.adaptSize,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage("${ApiConstant.baseImageUrl}$imageUrl"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          description ??
                              'Apply for credit service to get solar system with 0% interest rate.',
                          style: const TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: onTap,
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF1C4588),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    apply.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 0.19,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
