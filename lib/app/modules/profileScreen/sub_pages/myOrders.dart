import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';

import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/modules/myOrder/controllers/my_orders_controller.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  @override
  Widget build(BuildContext context) {
    Get.put(MyOrdersController());

    final MyOrdersController myOrdersController =
        Get.find<MyOrdersController>();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Obx(
            () => myOrdersController.isLoadingMyOrder.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : myOrdersController.orderList.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 40.h, left: 45.w),
                        child: Text('No order'),
                      )
                    : Container(
                        // color: Colors.amber,
                        height: 80.h,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: myOrdersController.orderList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  MyOrderWidget(
                                    onPressed: () => Get.toNamed(
                                      Routes.myOrderPage,
                                      arguments:
                                          myOrdersController.orderList[index],
                                    ),
                                    delivery: myOrdersController
                                            .orderList[index]
                                            .deliveryAddress
                                            ?.contactName ??
                                        "",
                                    imageUrl: Utils.getImageUrl(
                                            myOrdersController.orderList[index]
                                                .paymentImageUrl
                                                .toString()) ??
                                        '',
                                    itemNumber: myOrdersController
                                            .orderList[index].products?.length
                                            .toString() ??
                                        "",
                                    status_: myOrdersController
                                            .orderList[index].status ??
                                        "",
                                    price: myOrdersController
                                            .orderList[index].totalPrice ??
                                        "",
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                      ),
          ),
        ],
      ),
    );
  }
}

class MyOrderWidget extends StatelessWidget {
  final String imageUrl;
  final String itemNumber;
  final String price;
  final String delivery;
  final String status_;
  final VoidCallback? onPressed;
  const MyOrderWidget({
    super.key,
    required this.imageUrl,
    required this.itemNumber,
    required this.price,
    required this.delivery,
    required this.status_,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: CustomImageView(
                    imagePath: imageUrl,
                    height: 50,
                    width: 50,
                    radius: BorderRadius.circular(37.h),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${items.tr}: ",
                            style: theme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(itemNumber,
                            style: theme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("${totalPrice.tr}: ",
                            style: theme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(price,
                            style: theme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${deliverTo.tr}: ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          delivery,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${status.tr}: ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          status_,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
