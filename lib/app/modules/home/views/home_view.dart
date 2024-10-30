import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/modules/credit/creditScreen/views/credit_screen_view.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/views/profile_screen_view.dart';
import 'package:ethiosolar_app/app/modules/shopScreen/views/shop_screen_view.dart';
import 'package:ethiosolar_app/app/modules/trainingCategoryScreen/views/training_screen_view.dart';
import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
// import '../../../core/i18n/translation_keys.dart' as trs;

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) {
            controller.tabIndex.value = value;
          },
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.surface,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.decelerate,
          height: 60.adaptSize,
          items: [
            Icon(Icons.school_outlined,
                color: Theme.of(context).colorScheme.onPrimary),
            Icon(Icons.shopping_cart_outlined,
                color: Theme.of(context).colorScheme.onPrimary),
            Icon(Icons.credit_card_outlined,
                color: Theme.of(context).colorScheme.onPrimary),
            Icon(Icons.person_outline,
                color: Theme.of(context).colorScheme.onPrimary)
          ]),
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              const TrainingCategoryScreenView(),
              ShopScreenView(),
              const CreditScreenView(),
              const ProfileScreenView(),
            ],
          )),
    );
  }
}
