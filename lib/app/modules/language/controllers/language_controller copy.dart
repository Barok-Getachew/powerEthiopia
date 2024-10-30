import 'package:ethiosolar_app/app/core/exports/app_exports.dart';

class LanguageController extends GetxController {
  var selectedLanguage = "English".obs; // Initial language

  void updateLanguage(String language) {
    selectedLanguage.value = language;
  }
}
