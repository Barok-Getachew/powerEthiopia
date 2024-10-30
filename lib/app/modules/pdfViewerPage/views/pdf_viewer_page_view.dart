import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pdf_viewer_page_controller.dart';

class PdfViewerPageView extends GetView<PdfViewerPageController> {
  const PdfViewerPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PdfViewerPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PdfViewerPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
