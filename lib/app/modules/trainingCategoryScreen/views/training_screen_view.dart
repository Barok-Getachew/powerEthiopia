import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/data/models/carousel/carousel_model.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/trainingCategoryScreen/widget/trainingList.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'package:sizer/sizer.dart';
import '../../../core/exports/app_exports.dart';

import '../controllers/training_screen_controller.dart';

class TrainingCategoryScreenView
    extends GetView<TrainingCategoryScreenController> {
  const TrainingCategoryScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileScreenController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.v),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: Padding(
            padding: EdgeInsets.only(left: 24.adaptSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      speed: Duration(seconds: 1),
                      StringConstant.home_greeting,
                      textAlign: TextAlign.left,
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Text(
                  profileController.userModel?.fullName ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 7.adaptSize,
                ),
              ],
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 16.6.adaptSize,
              ),
              Text(
                StringConstant.home_headline,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                StringConstant.home_wellcome,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30.v),
          Obx(
            () => controller.isCarouselImageLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.trainingList.isEmpty
                    ? const Center(
                        child: SizedBox(),
                      )
                    : SizedBox(
                        width: 250.w,
                        height: 218.v,
                        child: ExpandableCarousel(
                          options: ExpandableCarouselOptions(
                            floatingIndicator: true,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            slideIndicator: CircularSlideIndicator(
                                slideIndicatorOptions: SlideIndicatorOptions(
                              indicatorBorderWidth: 1,
                              indicatorBorderColor: Colors.black26,
                              enableAnimation: true,
                              currentIndicatorColor:
                                  Theme.of(context).colorScheme.primary,
                            )),
                            autoPlayInterval: const Duration(seconds: 5),
                          ),
                          items: controller.carouselList
                              .map((CarouselModel image) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  width: 343.w,
                                  height: 175.v,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(Utils.getImageUrl(
                                          image.imageUrls?.first.toString() ??
                                              '')),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24.adaptSize),
              child: Text(
                StringConstant.home_training,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => controller.isTrainingCategoryLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.adaptSize),
                      child: Container(
                        padding: EdgeInsets.symmetric(),
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.adaptSize, vertical: 10.adaptSize),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 200.v,
                            mainAxisSpacing: 20.adaptSize,
                            crossAxisSpacing: 20.adaptSize,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TrainingWidget(
                            id: controller.trainingList[index].id ?? -1,
                            coverImage: Utils.getTrainingImageUrl(
                                controller.trainingList[index].imageUrl ?? ""),
                            title: controller.trainingList[index].title ?? "",
                            description:
                                controller.trainingList[index].description ??
                                    "",
                          ),
                          itemCount: controller.trainingList.length,
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
