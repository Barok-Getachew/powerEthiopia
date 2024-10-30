/* import 'package:ethiosolar_app/app/core/utils/theme/custom_text_style.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/custom_app_bar.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar_leading_image.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar_title.dart';
import 'package:ethiosolar_app/app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.v),
                Container(
                  width: 297.h,
                  margin: EdgeInsets.only(right: 37.h),
                  child: Text(
                    "Please read the following terms and conditions very carefully Aut sint velit ut tempore minus qui similique harum aut veniam cumque et tempora fuga.",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallOnPrimaryContainer,
                  ),
                ),
                SizedBox(height: 17.v),
                ...List.generate(
                    6,
                    (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 3.h),
                              child: Text(
                                "${index + 1}. This & That",
                                style: CustomTextStyles
                                    .labelLargeOnPrimaryContainer,
                              ),
                            ),
                            SizedBox(height: 9.v),
                            SizedBox(
                              width: 333.h,
                              child: Text(
                                "Lorem ipsum dolor sit amet. Aut sint velit ut tempore minus qui similique harum aut veniam cumque et tempora fuga. Quo placeat cupiditate sed dolorem voluptatem ut perspiciatis facilis sed quia illo. Ea repellat quos hic voluptate voluptates est nemo voluptas ut praesentium.",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles
                                    .bodySmallOnPrimaryContainer,
                              ),
                            ),
                            SizedBox(height: 27.v),
                          ],
                        )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildAcceptTerms(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 43.v,
      leadingWidth: 64.h,
      leading: AppbarLeadingImage(
        imagePath: 'assets/images/img_arrow_down.svg',
        margin: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 10.v,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      title: AppbarTitle(
        text: "Terms & Conditions",
        margin: EdgeInsets.only(left: 33.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildAcceptTerms(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CustomElevatedButton(
      text: "Accept Terms",
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 20.v,
      ),
      buttonTextStyle: theme.titleSmall,
    );
  }
}
 */