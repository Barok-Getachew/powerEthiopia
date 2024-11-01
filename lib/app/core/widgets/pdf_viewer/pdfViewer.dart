import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWidget extends StatefulWidget {
  final String url;
  final double height;

  const PdfViewerWidget({
    super.key,
    required this.url,
    required this.height,
  });

  @override
  // ignore: library_private_types_in_public_api
  PdfViewerWidgetState createState() => PdfViewerWidgetState();
}

class PdfViewerWidgetState extends State<PdfViewerWidget> {
  PdfViewerController controller = PdfViewerController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: widget.height.v,
        child: SfPdfViewer.network(
          widget.url,
          canShowScrollHead: false,
          canShowScrollStatus: false,
          pageSpacing: 0,
          controller: controller,
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            debugPrint(details.error);
          },
        ),
      ),
    );
  }
}
