import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';

class CircularLogo extends StatelessWidget {
  const CircularLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.adaptSize,
      height: 125.adaptSize,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
