import 'package:get/get.dart';

import 'am.dart';
import 'en.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': En().messages,
        'am_ET': Am().messages,
      };
}
