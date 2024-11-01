import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/pdf_viewer/pdfViewer.dart';
import 'package:ethiosolar_app/app/data/models/about/aboutUs_model.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/controllers/profile_screen_controller.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/sub_pages/about_power_screen.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/sub_pages/change_language_screen.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/sub_pages/customer_support_screen.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/sub_pages/feedback_screen.dart';
import 'package:ethiosolar_app/app/modules/profileScreen/sub_pages/myOrders.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreenView extends GetView<ProfileScreenController> {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SafeArea(child: Scaffold(body: Obx(() {
      return controller.isLoading.isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.adaptSize,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    CircleAvatar(
                      radius: 25.adaptSize,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        controller.userModel!.fullName!
                            .substring(0, 1)
                            .toUpperCase(),
                      ),
                    ),
                    SizedBox(width: 20.adaptSize),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.userModel?.fullName ?? "",
                            style: Theme.of(context).textTheme.headlineLarge),
                        SizedBox(height: 5.v),
                        Text(controller.userModel?.phoneNumber ?? "",
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  ]),
                  SizedBox(height: 45.v),
                  Text(
                    'Account Settings',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  settingListTile(
                      context,
                      theme,
                      Icons.person_2_outlined,
                      Icons.arrow_forward,
                      () => onTapUpdateInformation(context),
                      updateInformation.tr),
                  settingListTile(
                      context,
                      theme,
                      Icons.shop_outlined,
                      Icons.arrow_forward,
                      () => _buildMyOrders(context),
                      myOrders.tr),
                  settingListTile(
                      context,
                      theme,
                      Icons.maps_ugc_outlined,
                      Icons.arrow_forward,
                      () => onTapDeliveryAddress(context),
                      deliveryAddress.tr),
                  SizedBox(height: 20.v),
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  settingListTile(
                      context,
                      theme,
                      Icons.language_rounded,
                      Icons.arrow_forward,
                      () => onTapChangeLanguage(context),
                      changeLanguage.tr),
                  settingListTile(
                      context,
                      theme,
                      Icons.support,
                      Icons.arrow_forward,
                      () => onTapCustomerSupport(context),
                      customerSupport.tr),
                  settingListTile(
                      context,
                      theme,
                      Icons.info_outline,
                      Icons.arrow_forward,
                      () => onTapAboutPowerEthiopia(context),
                      "${about.tr} Power Ethiopia"),
                  settingListTile(
                      context,
                      theme,
                      Icons.feedback_outlined,
                      Icons.arrow_forward,
                      () => onTapGiveFeedback(context),
                      giveFeedback.tr),
                  settingListTile(
                      context,
                      theme,
                      Icons.text_format_outlined,
                      Icons.arrow_forward,
                      () => onTapTermsConditions(context),
                      'Terms & Conditions'),
                  ListTile(
                    leading: Icon(Icons.logout_outlined,
                        color: Theme.of(context).colorScheme.error),
                    contentPadding: EdgeInsets.all(0),
                    title: Text(logout.tr, style: theme.bodyMedium),
                    onTap: () {
                      Get.to(_buildLogOut(context));
                    },
                    trailing: Icon(Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ),
            ));
    })));
  }

  ListTile settingListTile(
      BuildContext context,
      TextTheme theme,
      IconData? leadIcon,
      IconData? trailinIcon,
      dynamic Function() thisFunction,
      String title) {
    ;
    return ListTile(
      leading: Icon(leadIcon, color: Theme.of(context).colorScheme.primary),
      contentPadding: EdgeInsets.all(0),
      title: Text(title, style: theme.bodyMedium),
      onTap: () {
        Get.to(thisFunction());
      },
      trailing: Icon(trailinIcon, color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildMyOrders(BuildContext context) {
    return CustomElevatedButton(
        text: myOrders.tr,
        buttonTextStyle: TextStyle(color: Colors.white),
        height: 44.h,
        onPressed: () {
          Get.to(() => MyOrderView());
          // Get.to(MyOrderView());
        });
  }

  /// Section Widget
  Widget _buildLogOut(BuildContext context) {
    return controller.isLogoutLoading.isTrue
        ? const CircularProgressIndicator.adaptive()
        : CustomElevatedButton(
            text: logout.tr,
            buttonTextStyle: TextStyle(color: Colors.white),
            height: 55.h,
            onPressed: () => controller.logout(),
          );
  }

  /// Navigates to the MyOrderView when the action is triggered.
  onTapMyDelivery(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrderView()));
  }

  /// Navigates to the aboutPowerScreen when the action is triggered.
  onTapAboutPowerEthiopia(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AboutPowerScreen(
                  aboutUs: controller.aboutUsModel ?? AboutUsModel(),
                )));
  }

  /// Navigates to the updateProfileScreen when the action is triggered.
  onTapUpdateInformation(BuildContext context) async {
    final userData = await Get.toNamed(Routes.updateProfileScreen,
        arguments: controller.userModel);
    if (userData != null) {
      controller.userModel = userData;
    }
  }

  /// Navigates to the changeLanguageScreen when the action is triggered.
  onTapChangeLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FractionallySizedBox(
        heightFactor: 0.65,
        child: ChangeLanguageScreen(),
      ),
    );
  }

  /// Navigates to the deliveryAddressScreen when the action is triggered.
  onTapDeliveryAddress(BuildContext context) {
    Get.toNamed(Routes.deliveryAddress);
  }

  /// Navigates to the changeLanguageOneScreen when the action is triggered.
  onTapCustomerSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.3,
        child: CustomerSupportScreen(
          customerSupport: controller.customerSupportList,
        ),
      ),
    );
  }

  /// Navigates to the feedbackScreen when the action is triggered.
  onTapGiveFeedback(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
            height: 380.adaptSize,
            width: double.infinity,
            child: FeedbackScreen()),
      ),
    );
  }

  /// Navigates to the termsScreen when the action is triggered.
  onTapTermsConditions(BuildContext context) {
    debugPrint("${ApiConstant.baseImageUrl}${controller.termModel?.pdfUrl}");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PdfViewerWidget(
                  height: MediaQuery.of(context).size.height * 0.8,
                  url:
                      "${ApiConstant.baseImageUrl}${controller.termModelList[0].pdfUrl}",
                )));
  }
}



// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/profile_screen_controller.dart';

// class ProfileScreenView extends GetView<ProfileScreenController> {
//   const ProfileScreenView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ProfileScreenView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: () {
//             controller.logout();
//             // Get.toNamed(Routes.login);
//           },
//           child: const Text(
//             'Logout',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
