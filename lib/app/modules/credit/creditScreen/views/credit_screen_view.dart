import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/modules/credit/creditDetail/views/credit_detail_screen.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.v),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 16.6.adaptSize,
              ),
              Text(
                'Credits',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          centerTitle: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20.v),
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
                        Get.to(CreditDetailScreen(
                          title: controller.creditList[index].title!,
                          description:
                              controller.creditList[index].description!,
                          index: index,
                        ));
                      },
                      description:
                          controller.creditList[index].description ?? "",
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: controller.creditList.length,
                  )),
          ],
        ),
      ),
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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    width: 65.adaptSize,
                    height: 65.adaptSize,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${ApiConstant.baseImageUrl}$imageUrl"),
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
                            letterSpacing: -0.17,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            description,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Color(0xFF222222),
                              letterSpacing: -0.17,
                              fontSize: 8,
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
            // const SizedBox(height: 10),
            // InkWell(
            //   onTap: onTap,
            //   child: Container(
            //     height: 38,
            //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //     clipBehavior: Clip.antiAlias,
            //     decoration: ShapeDecoration(
            //       color: const Color(0xFF1C4588),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(
            //           apply.tr,
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 12,
            //             fontWeight: FontWeight.w500,
            //             height: 0.19,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
