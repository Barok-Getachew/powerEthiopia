import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme.dart';

import 'package:ethiosolar_app/app/modules/signup/widgets/dropdown_city.dart';
import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:with_helper/with_helper.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/pdf_viewer/circular_logo.dart';
import '../controllers/language_controller copy.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: WithHelper().withSpacing(
              spacing: 8,
              children: [
                const SizedBox(height: 20),
                const CircularLogo(),
                SizedBox(height: 10.v),

                Column(
                  children: [
                    Text(
                      'ቋንቋ ይምረጡ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Choose Language',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    LanguageDropdown()
                    // LanguageDropdown(
                    //   selectedCity: 'English',
                    //   onChanged: (value) {
                    //     if (value == 'English') {
                    //       debugPrint('on english');
                    //       Get.updateLocale(const Locale('en', 'EN'));
                    //     } else if (value == 'አማርኛ') {
                    //       debugPrint('on amharic');
                    //       Get.updateLocale(const Locale('am', 'ET'));
                    //     } else {
                    //       debugPrint('on nothin english');
                    //       Get.updateLocale(const Locale('en', 'EN'));
                    //     }
                    //   },
                    // ),
                    /*   DropdownButton(
                      value: controller.selectedLanguage.value,
                      items: controller.languageModes.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang.name),
                        );
                      }).toList(),
                      onChanged: (lang) => controller.selectedLanguage.value,
                    ) */
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            // Get.updateLocale(const Locale('am', 'ET'));

                            Get.toNamed(Routes.aboutusOnboarding);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary),
                          child: Text(
                            continuee.tr,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                // const SizedBox(height: 48),
                // SizedBox(
                //   height: 50,
                //   child: ElevatedButton(
                //     onPressed: () => Get.toNamed(Routes.aboutusOnboarding),
                //     child: Obx(
                //       () => Text(
                //         controller.pickedLanguage.value,
                //         style: theme.bodyLarge?.copyWith(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
