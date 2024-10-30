import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:ethiosolar_app/app/core/i18n/translation_keys.dart' as trs;
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    this.formController,
  }) : super(key: key);

  final dynamic controller; // Replace with the correct type if possible
  final TextEditingController? formController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.labelSmall,
      controller: formController,
      keyboardType: TextInputType.text,
      focusNode: controller.passwordFocusNode,
      obscureText: !controller.isPasswordVisible.value,
      decoration: InputDecoration(
        hintText: trs.passwordPlaceholder.tr,
        prefixIcon: const Icon(
          Icons.key,
          color: Color.fromARGB(89, 0, 0, 0),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
            onPressed: controller.changePasswordVisibility,
          ),
        ),
        suffixIconColor: const Color.fromARGB(89, 0, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.adaptSize)),
          borderSide: const BorderSide(width: 1, color: Colors.black54),
        ),
      ),
    );
  }
}
