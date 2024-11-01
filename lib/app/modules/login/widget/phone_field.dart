import 'dart:async';

import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../core/i18n/translation_keys.dart' as trs;

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.controller,
    required this.phoneFocusNode,
    required this.nextFocusNode,
  });

  final dynamic controller;
  final FocusNode phoneFocusNode;
  final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      showDropdownIcon: false,
      initialCountryCode: 'ET',
      disableLengthCheck: true,
      initialValue: '12-345-678',
      flagsButtonPadding: EdgeInsets.only(left: 5),
      style: Theme.of(context).textTheme.labelMedium,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.adaptSize)),
              borderSide: BorderSide(width: 1)),
          hintText: trs.phoneNumber.tr),
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      focusNode: phoneFocusNode,
      onSubmitted: (value) {
        controller.onSubmittedPhone(value, context);
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
    );
  }
}
