import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/constants/constants.dart';

import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../core/i18n/translation_keys.dart' as trs;
import '../../../routes/app_pages.dart';
import '../../myOrder/controllers/my_orders_controller.dart';
import '../controllers/cart_screen_controller.dart';

class CartScreenView extends GetView<CartScreenController> {
  const CartScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    Get.find<MyOrdersController>();

    return Scaffold(
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 16.6.adaptSize,
                ),
                Text(
                  trs.cart,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            centerTitle: false,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Obx(() {
              return controller.cartItems.values.isEmpty
                  ? Center(
                      child: Text(
                        noItem.tr,
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 480.v,
                          child: ListView.builder(
                              itemCount: controller.cartItems.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    CartWidget(
                                      imageUrl: Utils.getImageUrl(
                                        controller.cartItems.values
                                                .toList()[index]
                                                .product
                                                ?.getImageUrl
                                                ?.first ??
                                            "",
                                      ),
                                      title: controller.cartItems.values
                                              .toList()[index]
                                              .product
                                              ?.name ??
                                          "",
                                      price:
                                          '${controller.cartItems.values.toList()[index].product?.price} ETB',
                                      quantity: controller.cartItems.values
                                          .toList()[index]
                                          .quantity
                                          .toString(),
                                      onRemoveItemPressed: () =>
                                          controller.removeItem(
                                        productModel: controller
                                            .cartItems.values
                                            .toList()[index]
                                            .product!,
                                      ),
                                      onAddPressed: () =>
                                          Get.find<CartScreenController>()
                                              .addItem(
                                        product: controller.cartItems.values
                                            .toList()[index]
                                            .product!,
                                        quantity: 1,
                                        useExistingQuantity: true,
                                        showDialog: false,
                                      ),
                                      onDecreasePressed: () {
                                        if (controller.cartItems.values
                                                .toList()[index]
                                                .quantity !=
                                            1) {
                                          int qty = controller.cartItems.values
                                              .toList()[index]
                                              .quantity!;
                                          qty -= 1;
                                          Get.find<CartScreenController>()
                                              .modifyCartQuantity(
                                            productModel: controller
                                                .cartItems.values
                                                .toList()[index]
                                                .product!,
                                            quantity: qty,
                                          );
                                        } else {
                                          Get.find<CartScreenController>()
                                              .removeItem(
                                            productModel: controller
                                                .cartItems.values
                                                .toList()[index]
                                                .product!,
                                          );
                                        }
                                      },
                                      description: controller.cartItems.values
                                              .toList()[index]
                                              .product
                                              ?.description ??
                                          "",
                                    ),
                                  ],
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 17,
                            ),
                            Obx(
                              () => Checkbox(
                                value: controller.isChecked.value,
                                onChanged: (value) => controller.toggle(),
                              ),
                            ),
                            SizedBox(
                                child: TextButton(
                              onPressed: () {},
                              child: Text(agreeTermsAndCondi.tr,
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 124.v,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: ShapeDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 20,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${total.tr}:',
                                      style: const TextStyle(
                                        color: Color(0xFF454A53),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.adaptSize,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.getTotalPrice().subTotal.value}",
                                          style: const TextStyle(
                                            color: Color(0xFF454A53),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'ETB',
                                          style: TextStyle(
                                            color: Color(0xFF454A53),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.adaptSize),
                              Obx(() => ElevatedButton(
                                    onPressed: () =>
                                        controller.proceedToCheckout(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.isChecked.value == false
                                              ? Colors.grey
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                    ),
                                    child: Text(
                                      trs.proceedToPayment.tr,
                                      style: theme.bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    );
            })));
    //my orders
  }
}

class CartWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final VoidCallback onRemoveItemPressed;
  final VoidCallback onAddPressed;
  final VoidCallback onDecreasePressed;
  final String quantity;
  const CartWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onRemoveItemPressed,
    required this.onAddPressed,
    required this.onDecreasePressed,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 335,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(35, 0, 0, 0),
              blurRadius: 2,
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: imageUrl,
              height: 175,
              width: 145,
              radius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.adaptSize),
                  topLeft: Radius.circular(10.adaptSize)),
            ),
            SizedBox(
              width: 5.adaptSize,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(title,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(price, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Stack(children: [
                                InkWell(
                                    onTap: onDecreasePressed,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: const Icon(Iconsax.minus,
                                          color: Colors.white),
                                    )),
                              ]),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              quantity,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 0,
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Stack(children: [
                                InkWell(
                                    onTap: onAddPressed,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      child: const Icon(Iconsax.add,
                                          color: Colors.white),
                                    )),
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 80.adaptSize, top: 10.adaptSize),
                          child: InkWell(
                            onTap: onRemoveItemPressed,
                            child: Text(
                              removeItem.tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
