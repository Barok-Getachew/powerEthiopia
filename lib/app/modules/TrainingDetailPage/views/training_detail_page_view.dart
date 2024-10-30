import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart' as tr;
import 'package:ethiosolar_app/app/modules/TrainingDetailPage/widget/paginatedWidget.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import '../controllers/training_detail_page_controller.dart';
import '../widget/training_detail_widget.dart';

class TrainingDetailPageView extends GetView<TrainingDetailPageController> {
  const TrainingDetailPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.v),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: Padding(
            padding: EdgeInsets.only(left: 24.adaptSize, top: 15.adaptSize),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                top: 16.adaptSize,
                right: 19.adaptSize,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  weight: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  Get.toNamed(Routes.notificationScreen);
                },
              ),
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 16.6.adaptSize,
              ),
              Text(
                tr.training,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          centerTitle: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const PaginationWidget(),
            const SizedBox(height: 20),
            Obx(
              () => controller.isTrainingCategoryTrainingsLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.trainingList.isEmpty
                      ? const Center(
                          child: Text(''),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 30.adaptSize),
                          itemCount: controller.trainingList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                debugPrint('index$index');

                                Get.toNamed(
                                  Routes.playingScreen,
                                  arguments: controller.trainingList[index].id,
                                );
                              },
                              child: TrainingDetailWidget(
                                trainingModel: controller.trainingList[index],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginatedWidget extends StatelessWidget {
  const PaginatedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: PaginationWidget(
                        isSelected: true,
                        pageNumber: "1",
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
