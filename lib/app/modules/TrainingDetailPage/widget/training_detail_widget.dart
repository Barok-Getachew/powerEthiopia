// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:ethiosolar_app/app/data/models/training/training_model.dart';
import 'package:ethiosolar_app/app/modules/TrainingDetailPage/widget/courseListWidget.dart';

class TrainingDetailWidget extends StatelessWidget {
  const TrainingDetailWidget({
    super.key,
    required this.trainingModel,
  });

  final TrainingModel trainingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CourseListWidget(
            imageUrl: Utils.getImageUrl(trainingModel.imageUrl ?? ""),
            courseVideoCount: "",
            coursePdfCount: "",
            courseName: trainingModel.title ?? "",
            courseDescription: trainingModel.description ?? "",
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
