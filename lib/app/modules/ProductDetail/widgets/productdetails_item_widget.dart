// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ethiosolar_app/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';

// ignore: must_be_immutable
class ProductdetailsItemWidget extends StatelessWidget {
  final String imageUrl;
  const ProductdetailsItemWidget({
    super.key,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 67.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: CustomImageView(
          imagePath: Utils.getImageUrl(imageUrl),
          height: 67.adaptSize,
          width: 67.adaptSize,
          radius: BorderRadius.circular(
            5.h,
          ),
        ),
      ),
    );
  }
}
