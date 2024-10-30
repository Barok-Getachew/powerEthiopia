import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';

class MultiLineFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool? countryCode;
  final bool? autoFocus;
  final bool? isMultiText;
  final String label;
  final Function(String)? onSubmitted;

  const MultiLineFieldInput({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.focusNode,
    this.countryCode = false,
    this.autoFocus = false,
    this.isMultiText,
    required this.label,
    this.onSubmitted,
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
              Container(
                padding: const EdgeInsets.all(8),
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
              const SizedBox(width: 10)
            ],
            Expanded(
              child: TextField(
                minLines: isMultiText ?? true ? 2 : 1,
                maxLines: 5,
                controller: controller,
                keyboardType: keyboardType,
                focusNode: focusNode,
                autofocus: autoFocus ?? false,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  contentPadding: isMultiText ?? true
                      ? const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
                      : const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
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
