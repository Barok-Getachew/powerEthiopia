import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utils {
  const Utils._();
  static String concatenateGoogleDriveUrl(String id) {
    // "https://drive.google.com/uc?export=download&id=1_hbvqFW5QRfZdDvvDROUeMSkuLGkadXP"
    const baseUrl = "https://drive.google.com/uc?export=download&id=";

    return baseUrl + id;
  }

  static String concatenateString(List<String> strings,
      [String pattern = " "]) {
    var data = "";
    for (var str in strings) {
      data += str + pattern;
    }
    if (data.endsWith(", ")) {
      data = data.substring(0, data.length - 2);
    }
    return data.trimRight();
  }

  static String getTrainingImageUrl(String imageName) =>
      concatenateString(["", imageName], "");

  static String getImageUrl(String imageName) =>
      concatenateString([ApiConstant.baseImageUrl, imageName], "");

  static String formatDateAsTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime);
  }
}
