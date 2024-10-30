import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final String pageNumber;
  final bool isSelected;
  const PaginationWidget({
    super.key,
    required this.pageNumber,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(10),
      decoration: isSelected
          ? ShapeDecoration(
              color: const Color(0xFF1C4588),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF1C4588)),
              borderRadius: BorderRadius.circular(5),
            )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            pageNumber.toString(),
            style: isSelected
                ? const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  )
                : const TextStyle(
                    color: Color(0xFF1C4588),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
          ),
        ],
      ),
    );
  }
}
