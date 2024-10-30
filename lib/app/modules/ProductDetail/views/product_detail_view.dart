import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/core/widgets/pdf_viewer/pdfViewer.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/modules/ProductDetail/controllers/product_detail_controller.dart';
import 'package:ethiosolar_app/app/modules/ProductDetail/views/videoViewer.dart';
import 'package:ethiosolar_app/app/modules/ProductDetail/widgets/productdetails_item_widget.dart';
import 'package:ethiosolar_app/app/modules/cartScreen/controllers/cart_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:ethiosolar_app/app/core/utils/url_launcher/custom_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.v),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: Padding(
              padding: EdgeInsets.only(left: 20.adaptSize, top: 15.adaptSize),
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
                  controller.productModel?.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            centerTitle: false,
          ),
        ),
        body: Obx(
          () => controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (controller.productId != null &&
                      controller.productModel == null)
                  ? const Center(
                      child: Text("Product Not found"),
                    )
                  : Stack(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          final String urlImage = controller
                                                      .selectedImageUrl.value ==
                                                  ""
                                              ? "${ApiConstant.baseImageUrl}${controller.productModel?.getImageUrl!.first}"
                                              : "${ApiConstant.baseImageUrl}${controller.selectedImageUrl.value}";
                                          debugPrint("urlImage $urlImage");

                                          Get.to(PhotoView(
                                            imageProvider:
                                                NetworkImage(urlImage),
                                          ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    20.adaptSize),
                                                topRight: Radius.circular(
                                                    20.adaptSize)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: CustomImageView(
                                            radius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            imagePath: controller
                                                        .selectedImageUrl
                                                        .value ==
                                                    ""
                                                ? Utils.getImageUrl(
                                                    controller.productModel
                                                            ?.imageUrl!.first ??
                                                        "",
                                                  )
                                                : Utils.getImageUrl(
                                                    controller
                                                        .selectedImageUrl.value,
                                                  ),
                                            height: 250.v,
                                            width: double.maxFinite,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 19.v),
                                      _buildProductDetailImages(context),
                                      SizedBox(height: 19.v),
                                      _buildStack(context),
                                      SizedBox(height: 0.v),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.h),
                                        child: Text(productDescription.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                      SizedBox(height: 5.v),
                                      Container(
                                          width: 270.h,
                                          margin: EdgeInsets.only(left: 20.h),
                                          child: Text(
                                              controller.productModel
                                                      ?.description ??
                                                  "",
                                              maxLines: 11,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall)),
                                      SizedBox(height: 40.v),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.adaptSize),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                debugPrint(
                                                    "controller.productModel?.getVideoUrl?.shopVideoUrl ${controller.productModel?.videoUrl}");
                                                if (controller
                                                        .productModel
                                                        ?.videoUrl
                                                        .first
                                                        .isEmpty ||
                                                    controller.productModel
                                                            ?.videoUrl.first ==
                                                        null) {
                                                  Get.snackbar("No Video",
                                                      "No Video Found");
                                                  return;
                                                } else {
                                                  Get.to(VideoViewer(
                                                    url: controller.productModel
                                                        ?.videoUrl.first,
                                                  ));
                                                }
                                              },
                                              child: Container(
                                                height: 38,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      146, 76, 217, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.adaptSize),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons
                                                        .video_collection_rounded),
                                                    SizedBox(
                                                        width: 5.adaptSize),
                                                    Text(
                                                      watchVideo.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                Get.to(PdfViewerWidget(
                                                  url: Utils.getImageUrl(
                                                    controller.productModel
                                                            ?.pdfUrl ??
                                                        "",
                                                  ),
                                                  height: 500,
                                                ));
                                              },
                                              child: Container(
                                                height: 38,
                                                width: 145,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      147, 76, 217, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.adaptSize),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.map_outlined),
                                                    SizedBox(
                                                        width: 5.adaptSize),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10.adaptSize),
                                                      height: 38,
                                                      width: 100,
                                                      child: Text(
                                                        maxLines: 2,
                                                        checkMaintenanceguide
                                                            .tr,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30.v),
                                      Padding(
                                          padding: EdgeInsets.only(left: 25.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 51.adaptSize,
                                                    top: 20.adaptSize,
                                                    bottom: 35.adaptSize),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (!controller
                                                        .productModel!
                                                        .isInStock!) {
                                                      Get.snackbar(
                                                          "Can't order",
                                                          "Out of stock");
                                                      return;
                                                    }
                                                    onTapOrderNow(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.adaptSize),
                                                    ),
                                                    width: 210,
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .shopping_bag_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          orderNow.tr,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(getSupport.tr,
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black)),
                                              Text(callOurSupport.tr,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black)),
                                              GetBuilder<
                                                  ProfileScreenController>(
                                                init:
                                                    ProfileScreenController(), // Initialize the controller

                                                initState: (_) {},
                                                builder: (controllersProf) {
                                                  if (controllersProf
                                                      .customerSupportList
                                                      .isEmpty) SizedBox.shrink;
                                                  return Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: SizedBox(
                                                      height: 100,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: controllersProf
                                                            .customerSupportList
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 30.0
                                                                      .adaptSize,
                                                                  top: 15.0
                                                                      .adaptSize,
                                                                ),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      launchPhone(controllersProf
                                                                              .customerSupportList[index]
                                                                              .phoneNumbers?[0] ??
                                                                          "0987654322");
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .phone_android_outlined,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .secondary,
                                                                        ),
                                                                        Text(
                                                                            controllersProf.customerSupportList[index].phoneNumbers?[0] ??
                                                                                "",
                                                                            style:
                                                                                theme.textTheme.bodyLarge!.copyWith(color: Colors.grey[600])),
                                                                      ],
                                                                    )),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          )),
                                      SizedBox(height: 40.v)
                                    ],
                                  ),
                                )),
                              ),

                              // _buildRow(context),
                            ]),
                      ],
                    ),
        ));
  }

  /// Section Widget
  Widget _buildProductDetailImages(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 67.v,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 30.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(width: 19.h);
          },
          itemCount: controller.productModel?.getImageUrl?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.selectedImageUrl.value =
                    (controller.productModel?.getImageUrl![index].toString() ??
                        "");
              },
              child: ProductdetailsItemWidget(
                imageUrl: controller.productModel?.getImageUrl![index] ?? "",
              ),
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStack(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 62.v,
          width: 335.h,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 302.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.productModel?.name ?? "",
                            maxLines: 2,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(
                            height: 4.adaptSize,
                          ),
                          Row(
                            children: [
                              Text(
                                controller.productModel?.price ?? "",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                " ETB",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ],
                          ),
                        ],
                      ))),
              Align(
                alignment: Alignment.centerRight,
                child: controller.productModel?.isInStock ?? true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Text(availableInStock.tr,
                                style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 18),
                          ])
                    : Text(outOfStock.tr,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRow(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 13.v),
        decoration: AppDecoration.fillIndigo,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: 'assets/images/img_cart.svg',
              height: 40.adaptSize,
              width: 40.adaptSize,
              color: Colors.white,
              onTap: () {
                onTapImgCart(context);
              }),
          const Spacer(),
          Padding(
              padding: EdgeInsets.only(top: 9.v, bottom: 6.v),
              child: Text("${controller.productModel?.price} ETB",
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          CustomElevatedButton(
              width: 123.h,
              text: orderNow.tr,
              margin: EdgeInsets.only(left: 15.h, right: 5.h),
              buttonStyle: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              buttonTextStyle: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              onPressed: () {
                if (!controller.productModel!.isInStock!) {
                  Get.snackbar("Can't order", "Out of stock");
                  return;
                }
                onTapOrderNow(context);
              })
        ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Get.back();
  }

  /// Navigates to the cartScreen when the action is triggered.
  onTapImgCart(BuildContext context) {
    Navigator.pushNamed(context, Routes.cartScreen);
  }

  /// Navigates to the cartScreen when the action is triggered.
  onTapOrderNow(BuildContext context) {
    Get.find<CartScreenController>().addItem(
      quantity: 1,
      context: context,
      product: controller.productModel,
    );
  }
}
