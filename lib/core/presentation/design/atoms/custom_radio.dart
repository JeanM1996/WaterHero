import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool active;
  final Function onTap;
  final double? sizeDot;

  const CustomRadio({
    super.key,
    required this.active,
    required this.onTap,
    this.sizeDot = 14.5,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 27,
        height: 27,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? colors.blue : colors.gray,
          border: Border.all(
            width: active ? 4 : 1,
            color: active ? colors.gray.withOpacity(.2) : colors.paragraphs,
          ),
        ),
        child: Center(
          child: Container(
            width: sizeDot,
            height: sizeDot,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
