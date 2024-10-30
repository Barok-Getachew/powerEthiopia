// ignore_for_file: unnecessary_overrides

import 'package:ethiosolar_app/app/data/models/checkout/checkout_cart_request_model.dart';
import 'package:ethiosolar_app/app/data/models/checkout/checkout_request_model.dart';
import 'package:ethiosolar_app/app/core/utils/store/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cart_model/cart_model.dart';
import '../../../data/models/product/product_model.dart';
import '../../../routes/app_pages.dart';

class CartScreenController extends GetxController {
  var isChecked = false.obs;

  RxMap<String, CartModel> cartItems = <String, CartModel>{}.obs;
  RxMap<String, CartModel> getAllCartItems() {
    return cartItems;
  }

  void toggle() {
    isChecked.value = !isChecked.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addItem(
      {int? quantity,
      ProductModel? product,
      BuildContext? context,
      showDialog = true,
      useExistingQuantity = false}) {
    if (cartItems.containsKey('${product!.id}')) {
      cartItems.update(
          '${product.id}',
          (existingCartItems) => CartModel(
                productId: existingCartItems.productId,
                product: existingCartItems.product,
                quantity: useExistingQuantity
                    ? existingCartItems.quantity! + quantity!
                    : quantity!,
              ));
    } else {
      cartItems.putIfAbsent(
        '${product.id}',
        () => CartModel(
          productId: product.id,
          quantity: quantity!,
          product: product,
        ),
      );
    }
    if (showDialog) {
      Get.snackbar('Success', 'Added to cart');
    }
  }

  CartModel? findItemById(int productId) {
    if (cartItems.keys.isNotEmpty && cartItems.containsKey('$productId')) {
      return cartItems.values
          .toList()
          .firstWhere((cartItem) => cartItem.productId == productId);
    } else {
      return null;
    }
  }

  void modifyCartQuantity(
      {required ProductModel productModel, required int quantity}) async {
    if (cartItems.containsKey('${productModel.id}')) {
      cartItems.update(
        '${productModel.id}',
        (existingCartItems) => CartModel(
          productId: existingCartItems.productId,
          product: existingCartItems.product,
          quantity: quantity,
        ),
      );
    }
  }

  void removeItem({required ProductModel productModel}) {
    cartItems.remove('${productModel.id}');
  }

  void removeSingleItem(String productId, [isFromDescription = false]) {
    if (cartItems.containsKey(productId)) {
      return;
    }
    if (cartItems[productId]!.quantity! > 1) {
      cartItems.update(
          productId,
          (existingCartItem) => CartModel(
                productId: existingCartItem.productId,
                product: existingCartItem.product,
                quantity: existingCartItem.quantity! - 1,
              ));
    } else {
      cartItems.remove(productId);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  ({RxDouble subTotal, RxDouble totalPrice}) getTotalPrice() {
    double sum = 0;
    cartItems.forEach((key, value) {
      String price = value.product?.price ?? "";
      if (price.contains(",")) {
        price = price.replaceAll(",", "");
      }
      sum += double.parse(price) * value.quantity!;
    });
    return (subTotal: sum.obs, totalPrice: ((sum * 0.15) + sum).obs);
  }

  void proceedToCheckout() async {
    final List<CheckoutCartRequestModel> carts = [];
    getAllCartItems().values.forEach((cart) {
      carts.add(CheckoutCartRequestModel(
          id: cart.productId, quantity: cart.quantity));
    });
    CheckoutRequestModel checkoutRequest = CheckoutRequestModel();
    checkoutRequest = checkoutRequest.copyWith(
      checkoutCart: carts,
      deliveryLocation: "",
      paymentId: "",
      paymentImageUrl: "",
      totalPrice: getTotalPrice().subTotal.toString(),
      userId: int.parse(
        await UserSession.getUserId(),
      ),
    );

    Get.toNamed(Routes.checkoutScreen, arguments: checkoutRequest);
  }
}
