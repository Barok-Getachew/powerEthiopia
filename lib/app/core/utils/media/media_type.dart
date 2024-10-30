import 'package:http_parser/http_parser.dart';

class MediaTypeUtil {
  MediaType? getMediaType(String fileName) {
    if (fileName.endsWith("apng")) {
      return MediaType.parse("image/apng");
    } else if (fileName.endsWith("avif")) {
      return MediaType.parse("image/avif");
    } else if (fileName.endsWith("gif")) {
      return MediaType.parse("image/gif");
    } else if (fileName.endsWith("jpg") ||
        fileName.endsWith("jpeg") ||
        fileName.endsWith("jfif") ||
        fileName.endsWith("pjpeg") ||
        fileName.endsWith("pjp")) {
      return MediaType.parse("image/jpeg");
    } else if (fileName.endsWith("png")) {
      return MediaType.parse("image/png");
    } else if (fileName.endsWith("svg")) {
      return MediaType.parse("image/svg+xml");
    } else if (fileName.endsWith("webp")) {
      return MediaType.parse("image/webp");
    } else {
      throw Exception("Unsupported Media File Type");
    }
  }
}
