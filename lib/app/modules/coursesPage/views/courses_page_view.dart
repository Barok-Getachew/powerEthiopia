import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/courses_page_controller.dart';

class CoursesPageView extends GetView<CoursesPageController> {
  const CoursesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoursesPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoursesPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
