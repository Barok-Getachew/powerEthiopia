import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:flutter/material.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductcardItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> descriptions;
  final String price;
  final Function() onOrderNowPressed;
  final Function() onPressed;
  const ProductcardItemWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.descriptions,
    required this.price,
    required this.onOrderNowPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomImageView(
            imagePath: imagePath,
            height: 30.h,
            width: 90.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                title.toUpperCase(),
                style: theme.bodyLarge!.copyWith(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  descriptions.length,
                  (index) => SizedBox(
                    width: 90.w,
                    child: Text(descriptions[index],
                        textAlign: TextAlign.left,
                        style:
                            theme.bodySmall!.copyWith(color: Colors.black87)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    price,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12, height: 1.5),
                    style: theme.bodyLarge!.copyWith(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  text: orderNow.tr,
                  width: 120,
                  height: 35,
                  buttonStyle: ButtonStyle(
                      padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 10))),
                  buttonTextStyle: theme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  onPressed: onOrderNowPressed,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade400,
            indent: 12,
            endIndent: 12,
          ),
        ],
      ),
    );
  }
}
