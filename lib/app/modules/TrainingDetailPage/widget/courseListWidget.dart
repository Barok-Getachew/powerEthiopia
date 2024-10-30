import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class CourseListWidget extends StatelessWidget {
  final String imageUrl;
  final String courseName;
  final String courseDescription;
  final String courseVideoCount;
  final String coursePdfCount;
  const CourseListWidget({
    super.key,
    required this.imageUrl,
    required this.courseName,
    required this.courseDescription,
    required this.courseVideoCount,
    required this.coursePdfCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.adaptSize),
      child: Container(
        height: 171.adaptSize,
        width: double.infinity,
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
        child: Row(
          children: [
            Container(
              height: 180.adaptSize,
              width: 155.adaptSize,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.adaptSize),
                    bottomLeft: Radius.circular(20.adaptSize)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 30.adaptSize, left: 10.adaptSize),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.adaptSize,
                        child: Text(
                          courseName,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 10.adaptSize),
                      SizedBox(
                        width: 150.adaptSize,
                        child: Text(
                          courseDescription,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 36.adaptSize),
                      Container(
                          margin: EdgeInsets.only(left: 35.adaptSize),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: ShapeDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.adaptSize),
                            ),
                          ),
                          child: Text('Take Training',
                              style:
                                  Theme.of(context).textTheme.headlineMedium)),
                    ])),
          ],
        ),
      ),
    );
  }
}
