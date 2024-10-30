import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_title_searchview.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/custom_app_bar.dart';
import 'package:ethiosolar_app/app/modules/cartScreen/controllers/cart_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/shopScreen/controllers/shop_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/shopScreen/widgets/featuredcardlist_item_widget.dart';

import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/appbar/products_search.dart';
import '../widgets/all_product_card.dart';

// ignore_for_file: must_be_immutable
class ShopScreenView extends GetView<ShopScreenController> {
  ShopScreenView({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () => controller.getAllProduct(),
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(newProduct.tr,
                          style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => controller.isProductLoading.isTrue
                        ? const SizedBox.shrink()
                        : _buildFeaturedCard(context),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        allProducts.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => controller.isProductLoading.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.productList.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(),
                              itemBuilder: (context, index) => InkWell(
                                onTap: () => Get.toNamed(Routes.productDetail,
                                    arguments: controller.productList[index]),
                                child: AllcardItemWidget(
                                  product: controller.productList[index],
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 74.v,
      color: Theme.of(context).colorScheme.primary,
      title: AppbarTitleSearchview(
        onTapSearch: () => showSearch(
          context: context,
          delegate: ProductSearch(controller: controller),
        ),
        padding: EdgeInsets.only(left: 20.adaptSize),
        hintText: searchHere.tr,
        controller: searchController,
      ),
      actions: [
        Obx(
          () => Badge.count(
            isLabelVisible:
                Get.find<CartScreenController>().getAllCartItems().isNotEmpty,
            offset: const Offset(-1, 5),
            count: Get.find<CartScreenController>().getAllCartItems().length,
            child: IconButton(
              padding: EdgeInsets.only(left: 10.adaptSize),
              onPressed: () => Get.toNamed(Routes.cartScreen),
              color: Theme.of(context).colorScheme.onPrimary,
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(right: 10.adaptSize),
          onPressed: () => Get.toNamed(Routes.notificationScreen),
          icon: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(BuildContext context) {
    return SizedBox(
      height: 170.v,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 15),
        scrollDirection: Axis.horizontal,
        itemCount: controller.newProductList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.toNamed(Routes.productDetail,
                arguments: controller.newProductList[index]),
            child: FeaturedcardItemWidget(
              product: controller.newProductList[index],
            ),
          );
        },
      ),
    );
  }
}
