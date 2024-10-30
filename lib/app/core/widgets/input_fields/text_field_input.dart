import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';

class TextFieldInput extends StatelessWidget {
  final int? maxCharacters;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool? obscureText;
  final bool? countryCode;
  final bool? autoFocus;
  final bool? isMultiText;
  final String label;
  final bool? prefixIconEnabled;
  final IconData? prefixIcon;
  final Function(String)? onSubmitted;

  const TextFieldInput({
    super.key,
    this.maxCharacters,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.focusNode,
    this.obscureText = false,
    this.countryCode = false,
    this.autoFocus = false,
    this.isMultiText,
    required this.label,
    this.onSubmitted,
    this.prefixIcon,
    this.prefixIconEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            if (countryCode ?? false) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "+251",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10)
            ],
            Expanded(
              child: TextField(
                maxLength: maxCharacters,
                controller: controller,
                keyboardType: keyboardType,
                focusNode: focusNode,
                obscureText: obscureText ?? false,
                autofocus: autoFocus ?? false,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  prefixIcon: prefixIconEnabled ?? false
                      ? Icon(
                          prefixIcon,
                          color: Colors.grey.shade400,
                        )
                      : null,
                  contentPadding: isMultiText ?? true
                      ? const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
                      : const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7A7A7A),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color(0xFFE2E1E5) //Colors.grey.shade100,
                        ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
