import 'package:ethiosolar_app/app/core/exports/app_exports.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/controllers/language_controller copy.dart';

class LanguageDropdown extends StatelessWidget {
  final LanguageController controller =
      Get.put(LanguageController()); // Initialize controller

  LanguageDropdown({super.key});

  final List<String> languages = [
    "English",
    "አማርኛ",
    "Afan Oromo",
    "ትግርኛ",
    "Afar",
    "Wolayttatto Doonaa",
    "Somali"
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
                100, 100, 0, 0), // Adjust this to position dropdown
            items: languages.map((String language) {
              return PopupMenuItem<String>(
                height: 27, // Adjust height if needed
                value: language,
                child: Text(
                  language,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
          ).then((selectedValue) {
            if (selectedValue != null) {
              controller.updateLanguage(
                  selectedValue); // Update the language in the controller
              _updateLocale(
                  selectedValue); // Update the locale based on selected language
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.only(left: 13.0, top: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.selectedLanguage
                    .value, // Use the selected language from the controller
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      );
    });
  }

  void _updateLocale(String value) {
    if (value == 'English') {
      debugPrint('on english');
      Get.updateLocale(const Locale('en', 'EN'));
    } else if (value == 'አማርኛ') {
      debugPrint('on amharic');
      Get.updateLocale(const Locale('am', 'ET'));
    } else {
      debugPrint('on default language');
      Get.updateLocale(const Locale('en', 'EN'));
    }
  }
}
