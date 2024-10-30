// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class BankListWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? accountNumber;
  final Function()? onTap;
  final int? selectedBankInfoId;
  final int? bankInfoId;
  const BankListWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.accountNumber,
    this.onTap,
    this.selectedBankInfoId,
    this.bankInfoId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color:
              (selectedBankInfoId != null && selectedBankInfoId == bankInfoId)
                  ? Colors.grey
                  : Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE2E1E5)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl.toString() ??
                          "https://via.placeholder.com/25x25"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  name ?? "Bank Name",
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0.19,
                  ),
                ),
              ],
            ),
            Text(
              accountNumber ?? "123456789",
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 0.19,
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(bottom: 8),
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: accountNumber.toString()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Text copied to clipboard')),
                );
              },
              icon: const Icon(Iconsax.document_copy),
            ),
          ],
        ),
      ),
    );
  }
}
