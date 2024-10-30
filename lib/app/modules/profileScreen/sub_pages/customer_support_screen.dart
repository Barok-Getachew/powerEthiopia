import 'package:ethiosolar_app/app/core/utils/url_launcher/custom_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/data/models/customer_support/customer_support_model.dart';

class CustomerSupportScreen extends StatelessWidget {
  final List<CustomerSupportModel> customerSupport;
  const CustomerSupportScreen({
    super.key,
    required this.customerSupport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.h),
            topRight: Radius.circular(20.h),
          ),
        ),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 39.h,
          vertical: 20.v,
        ),
        child: Column(
          children: [
            CustomImageView(
              imagePath: 'assets/images/img_line_4.svg',
              height: 5.v,
              width: 40.h,
            ),
            SizedBox(height: 16.v),
            Text("Customer Support",
                style: theme.titleMedium?.copyWith(
                  color: const Color(0xFF222222),
                  fontSize: 32.fSize,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 24.v),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  itemCount: customerSupport.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            launchPhone(
                                customerSupport[index].phoneNumbers?[0] ??
                                    "0987654322");
                          },
                          child: Text(
                            customerSupport[index].phoneNumbers?[0] ?? "",
                            style: theme.headlineLarge?.copyWith(
                              color: const Color(0xFF222222),
                              fontSize: 24.fSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.v),
                        Divider(
                          thickness: 0.5.h,
                        ),
                        SizedBox(height: 10.v),
                      ],
                    );
                  }),
            ),
            // SizedBox(height: 5.v),
            // Divider(
            //   thickness: 0.5.h,
            // ),
            // SizedBox(height: 10.v),
            // Text(
            //   "+251-973-234-137",
            //   style: theme.textTheme.headlineLarge?.copyWith(
            //     color: const Color(0xFF222222),
            //     fontSize: 24.fSize,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // SizedBox(height: 5.v),
          ],
        ),
      ),
    );
  }
}
