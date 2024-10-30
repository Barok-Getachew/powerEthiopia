import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import '../../../routes/app_pages.dart';
import '../controllers/my_order_detail_controller.dart';

class MyOrderDetailView extends GetView<MyOrderDetailController> {
  const MyOrderDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myOrders.tr,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              color: Color(0xFF222222),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 0,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: controller.order == null
            ? const Center(
                child: Text("Order detail not found"),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    OrderDetailWidget(
                      date_: Utils.formatDateAsTimeAgo(
                          controller.order?.createdAt ?? DateTime.now()),
                      status_: controller.order?.status ?? "",
                      totalPrice_: controller.order?.totalPrice ?? "",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DeliveryWidget(
                      name_:
                          controller.order?.deliveryAddress?.contactName ?? "",
                      city_: controller.order?.deliveryAddress?.city ?? "",
                      address_:
                          controller.order?.deliveryAddress?.address ?? "",
                      phoneNumber_:
                          controller.order?.deliveryAddress?.phoneNumber ?? "",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.order?.products == null
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ProductWidget(
                              imageUrl: controller.order!.products![index]
                                      .getImageUrl?.first ??
                                  "",
                              name: controller.order!.products![index].name!,
                              price: controller.order!.products![index].price!,
                              quantity: controller.order?.products?[index]
                                      .productCheckout?.quantity
                                      .toString() ??
                                  "",
                              onPressed: () => Get.toNamed(
                                Routes.productDetail,
                                arguments:
                                    controller.order!.products![index].id,
                              ),
                            ),
                            itemCount: controller.order!.products!.length,
                          )
                  ],
                ),
              ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String quantity;
  final VoidCallback onPressed;
  const ProductWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            products.tr,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFE2E1E5)),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: CustomImageView(
                      imagePath: Utils.getImageUrl(imageUrl),
                      height: 75.adaptSize,
                      width: 75.adaptSize,
                      radius: BorderRadius.circular(37.h),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${trName.tr}: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(name),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            '${trPrice.tr}: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(price),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            '${trQuantity.tr}: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(quantity),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DeliveryWidget extends StatelessWidget {
  final String name_;
  final String city_;
  final String address_;
  final String phoneNumber_;
  const DeliveryWidget({
    super.key,
    required this.name_,
    required this.city_,
    required this.address_,
    required this.phoneNumber_,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          deliveryAddress.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFE2E1E5)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${trName.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(name_),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '${city.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(city_),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '${address.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(address_),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '${phoneNumber.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(phoneNumber_),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class OrderDetailWidget extends StatelessWidget {
  final String totalPrice_;
  final String date_;
  final String status_;
  const OrderDetailWidget({
    super.key,
    required this.totalPrice_,
    required this.date_,
    required this.status_,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          orderDetail.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFE2E1E5)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${totalPrice.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(totalPrice_),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '${trDate.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(date_),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '${status.tr}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(status_),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
