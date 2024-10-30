import 'package:ethiosolar_app/app/core/exports/app_exports.dart';

import 'package:ethiosolar_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../core/utils/utils.dart';

class TrainingWidget extends StatelessWidget {
  final String coverImage;
  final String title;
  final String description;
  final int id;
  const TrainingWidget({
    super.key,
    required this.coverImage,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.trainingDetailPage,
        arguments: id,
      ),
      child: Container(
        height: 90.v,
        width: 120.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20.adaptSize),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.v,
              width: 120.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(Utils.getImageUrl(coverImage)),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.adaptSize),
                    topRight: Radius.circular(20.adaptSize)),
              ),
            ),
            SizedBox(height: 5.v),
            Padding(
              padding: EdgeInsets.only(left: 10.adaptSize, right: 10.adaptSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 4.v),
                  Text(
                    maxLines: 3,
                    description,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
