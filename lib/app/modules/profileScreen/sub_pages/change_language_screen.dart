import 'package:ethiosolar_app/app/core/utils/theme/theme_helper.dart';
import 'package:ethiosolar_app/app/core/widgets/photo_viewer/custom_image_view.dart';
import 'package:ethiosolar_app/app/core/widgets/buttons/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String radioGroup = "";

  String radioGroup1 = "";

  String radioGroup2 = "";

  String radioGroup3 = "";

  String radioGroup4 = "";

  String radioGroup5 = "";

  String radioGroup6 = "";

  String radioGroup7 = "";
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.h),
            topRight: Radius.circular(20.h),
          ),
        ),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 30.h,
          vertical: 20.v,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomImageView(
                imagePath: 'assets/images/img_line_4.svg',
                height: 5.v,
                width: 40.h,
              ),
              SizedBox(height: 15.v),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    Get.updateLocale(const Locale('en', 'EN'));

                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: Text(
                  'አማርኛ',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF222222),
                    fontFamily: 'Nyala',
                  ),
                ),
                value: 'አማርኛ',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    Get.updateLocale(const Locale('am', 'ET'));

                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: const Text('Afan Oromo'),
                value: 'Afan Oromo',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: const Text('Somali'),
                value: 'Somali',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: const Text('Tigrigna'),
                value: 'Tigrigna',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: const Text('Wolayitegna'),
                value: 'Wolayitegna',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: const Text('Hadiyissa'),
                value: 'Hadiyissa',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ),
              RadioListTile<String>(
                enableFeedback: true,
                title: const Text('Guragegna'),
                value: 'Guragegna',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              /*
              _buildLanguageSelection(context),
              SizedBox(height: 5.v),
              Divider(
                thickness: 0.5.h,
              ), 
                SizedBox(height: 10.v),  
                _buildLanguageSelection1(context),
                SizedBox(height: 5.v),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(height: 10.v),
                _buildLanguageSelection2(context),
                SizedBox(height: 5.v),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(height: 10.v),
                _buildLanguageSelection3(context),
                SizedBox(height: 5.v),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(height: 10.v),
                _buildLanguageSelection4(context),
                SizedBox(height: 5.v),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(height: 10.v),
                _buildLanguageSelection5(context),
                SizedBox(height: 5.v),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(height: 10.v),
                _buildLanguageSelection6(context),
                SizedBox(height: 5.v),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(height: 10.v),
                _buildLanguageSelection7(context),
                SizedBox(height: 5.v), */
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "English",
      value: "English",
      groupValue: radioGroup,
      isRightCheck: true,
      onChange: (value) {
        radioGroup = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection1(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "አማርኛ",
      value: "አማርኛ",
      groupValue: radioGroup1,
      textStyle: theme.textTheme.titleLarge?.copyWith(
        color: const Color(0xFF222222),
        fontFamily: 'Nyala',
      ),
      isRightCheck: true,
      onChange: (value) {
        radioGroup1 = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection2(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "Afan Oromo",
      value: "Afan Oromo",
      groupValue: radioGroup2,
      isRightCheck: true,
      onChange: (value) {
        radioGroup2 = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection3(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "Somali",
      value: "Somali",
      groupValue: radioGroup3,
      isRightCheck: true,
      onChange: (value) {
        radioGroup3 = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection4(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "Tigrigna",
      value: "Tigrigna",
      groupValue: radioGroup4,
      isRightCheck: true,
      onChange: (value) {
        radioGroup4 = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection5(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "Welayita",
      value: "Welayita",
      groupValue: radioGroup5,
      isRightCheck: true,
      onChange: (value) {
        radioGroup5 = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection6(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "Adisa",
      value: "Adisa",
      groupValue: radioGroup6,
      isRightCheck: true,
      onChange: (value) {
        radioGroup6 = value;
      },
    );
  }

  /// Section Widget
  Widget _buildLanguageSelection7(BuildContext context) {
    return CustomRadioButton(
      width: 315.h,
      text: "Gurage",
      value: "Gurage",
      groupValue: radioGroup7,
      isRightCheck: true,
      onChange: (value) {
        radioGroup7 = value;
      },
    );
  }
}
