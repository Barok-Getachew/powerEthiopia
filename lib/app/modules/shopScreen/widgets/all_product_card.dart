import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/modules/cartScreen/controllers/cart_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/i18n/translation_keys.dart';
import '../../../data/models/product/product_model.dart';

class AllcardItemWidget extends StatelessWidget {
  const AllcardItemWidget({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20.adaptSize),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      width: 340.adaptSize,
      height: 170.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 250.h,
            width: 155,
            child: CustomImageView(
              radius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.adaptSize),
                  topLeft: Radius.circular(20.adaptSize)),
              fit: BoxFit.cover,
              imagePath: Utils.getImageUrl(product.getImageUrl?.first ?? ""),
              height: 250.v,
              width: 200.h,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.v,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.name ?? "",
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 4.v),
                SizedBox(
                  height: 20.v,
                  child: Text(
                    product.description ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.v, bottom: 3.v, right: 84),
                  child: Row(
                    children: [
                      Text(
                        "${product.price} ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        "ETB",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.adaptSize, top: 5),
                  child: InkWell(
                    onTap: () => Get.find<CartScreenController>().addItem(
                      quantity: 1,
                      context: context,
                      product: product,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10.adaptSize),
                      ),
                      width: 170,
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            orderNow.tr,
                            style: Theme.of(context).textTheme.headlineMedium,
                          )
                        ],
                      ),
                    ),
                  ),

                  //  CustomElevatedButton(
                  //   onPressed: () => Get.find<CartScreenController>().addItem(
                  //     quantity: 1,
                  //     context: context,
                  //     product: product,
                  //   ),
                  //   text: orderNow.tr,
                  //   width: 170,
                  //   height: 35,
                  //   buttonStyle: ButtonStyle(
                  //       backgroundColor: WidgetStateProperty.all(
                  //           Theme.of(context).colorScheme.primary),
                  //       padding: WidgetStateProperty.all(
                  //           EdgeInsets.symmetric(horizontal: 10))),
                  //   buttonTextStyle: theme.bodyLarge!.copyWith(
                  //     color: Colors.white,
                  //     fontSize: 15,
                  //   ),
                  // ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
