import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:ethiosolar_app/app/core/widgets/pdf_viewer/pdfViewer.dart';
import 'package:ethiosolar_app/app/data/services/api_constant.dart';
import 'package:ethiosolar_app/app/core/utils/url_launcher/custom_url_launcher.dart';
import 'package:flutter/material.dart';

import 'package:ethiosolar_app/app/core/widgets/appbar/custom_app_bar.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_leading_image.dart';
import 'package:ethiosolar_app/app/core/widgets/appbar/appbar_title.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/data/models/about/aboutUs_model.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AboutPowerScreen extends StatelessWidget {
  final AboutUsModel aboutUs;
  const AboutPowerScreen({
    super.key,
    required this.aboutUs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
          child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 19,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          PdfViewerWidget(
            height: 75,
            url: "${ApiConstant.baseImageUrl}${aboutUs.pdfUrl}" ?? '',
          ),
          //     Text(
          //       "Skylink trading PLC",
          //       style: CustomTextStyles.titleSmallOnPrimaryContainer,
          //     ),
          //     SizedBox(height: 8.v),
          //     SizedBox(
          //       width: 335.h,
          //       child: Text(
          //         "Skylink trading PLC was founded in 2016 by Mr. Tesfaye wube in the central Addis Abeba Ethiopia province of Ethiopia. The business soon expanded from being a small local electrical solutions company into one of Ethiopian’s largest and top electrical, hybrid Solar construction and installation establishments. Skylink trading PLC now employs 32 staff across its services and projects business units.\n\nThe company is registered and fully compliant in Ethiopia with the license trade of Electrical equipment’s and related appliances, Electrical and electromechanical and consultancy service on education. Power Ethiopia Technology is the brand name of Skylink trading PLC, which works on supply and distribution of electromechanical works, environmentally friendly energy products, and green energy. Skylink trading PLC delivers high quality equipment, installations and service maintenance outcomes for a wide range of clients. \n\nOur trained electricians can resolve the most complex of electrical, hybrid solar power issues and have built a solid reputation of successfully delivering premier electrical, solar power contracting and maintenance solutions for public sectors and private customers in commercial, domestic and industrial markets throughout Ethiopia. Skylink trading PLC have registered companies in Ethiopia. With local teams in full employment in most of this country. \n\nSkylink trading PLC assign highly skilled project managers from Ethiopia to oversee all work and projects across the country. Skylink trading PLC has been providing electrical and hybrid power installations and services maintenance for 3 years and places great emphasis on our relationship with clients, private or commercial, and pride ourselves on the ability to respond to our clients’ needs in an efficient and cost-effective way. \n\nSkylink trading PLC, is proud to be a true Ethiopian product, designed, build and accomplished by local Ethiopians for Ethiopia and for all of Africa. Our staffs are highly qualified electricians with legitimate Wireman Licenses, registered with the Department of Ethiopian energy and petroleum minster. Skylink trading PLC has an in-house AutoCAD design team, and is able to design and print electrical and network schematics. \n\nThe key customers for skylink trading are: \n\n• Government \n• Power and water utility companies \n• Non-governmental companies \n• International and local contractors \n• Industries and factories \n• World organization programs i.e., world bank, Africa development bank, European projects. \n• Institutions \n• Retail and showroom customers \n\nVision: we aspire to be the supplier of choice for the diversified industrial sector and governments in Ethiopia. 4 Mission: we strive to provide a one-stop quality proven up-to-dated technologies and equipment, that is supplemented with professional and technical support service. \n\nValues: our values guide the way we work with our business partners, within our communities and with each other. \nThese values are: \n• Partnership: we care to build and maintain long-term, bi-directional relationships our customers and suppliers in order to create strategic benefits to all parties. \n• Client satisfaction and support: we listen to our clients. We invest in quality technologies and facilities and knowledge transfer necessary to enhance and execute customer inquiries. Our team: we take pride in the diversity of our team members. Treat one another with respect appreciate the ideas of each individual. \n• Positive attitude and passion: we are passionate about what we do and aggressively promote and protect our reputations. \n• Social responsibility: we provide regular seminars and straining programs to share the latest developments knowledge to help develop the electrical industry sector in Ethiopia. We believe in quality, affordability, fair trade and mutual long-term growth. Our doors are always open to establish business relationships especially with green oriented global leader companies and governments from all over the world. Our Goals We strive to connect communities by the lighting the way. To do this, we continually upgrade our products and services that we offer to our customers. We provide our customers with rapid responses to their requests, and we continuously improve our levels of service prevision. Culture through our values we have created a company culture where ideas can blossom, people can thrive, and success can flourish.",
          //         maxLines: 35,
          //         overflow: TextOverflow.ellipsis,
          //         style: CustomTextStyles.bodyMediumOnPrimaryContainer,
          //       ),
          //     ),
          //   ],
          // ),
        ]),
      )),
      bottomNavigationBar: _buildVisitOurWebsite(context),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64,
      leading: AppbarLeadingImage(
        imagePath: 'assets/images/img_arrow_down.svg',
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "${about.tr} Power Ethiopia",
      ),
    );
  }

  /// Section Widget
  Widget _buildVisitOurWebsite(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        launchURL(aboutUs.websiteUrl ?? "https://google.com");
      },
      height: 38,
      text: "Visit our website",
      buttonTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 26,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 20.h),
        child: CustomImageView(
          imagePath: 'assets/images/img_globe.svg',
          height: 20,
          width: 20,
          color: Colors.white,
        ),
      ),
      // buttonTextStyle: theme.labelLarge,
    );
  }
}
