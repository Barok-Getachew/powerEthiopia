import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart';
import 'package:flutter/material.dart';

import 'package:ethiosolar_app/app/core/widgets/appbar/custom_search_view.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  const AppbarTitleSearchview({
    super.key,
    this.hintText,
    required this.controller,
    this.padding,
    required this.onTapSearch,
  });

  final String? hintText;
  final TextEditingController controller;

  final EdgeInsetsGeometry? padding;
  final Function() onTapSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: onTapSearch,
        child: CustomSearchView(
          autofocus: false,
          filled: true,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          fillColor: Theme.of(context).colorScheme.onPrimary,
          focusNode: FocusNode(),
          onChanged: (value) {},
          controller: controller,
          hintText: searchHere.tr,
        ),
      ),
    );
  }
}
