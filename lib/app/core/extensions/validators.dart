import '../utils/utils.dart';

extension Validator on String {
  String? validateField({required String fieldName}) {
    const errorMessage = "can't  be empty";
    if (isEmpty) {
      return Utils.concatenateString([fieldName, errorMessage]);
    }
    return null;
  }
}
