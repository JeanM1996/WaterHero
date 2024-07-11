import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/tokens.dart';

class CircleMarker extends StatelessWidget {
  const CircleMarker({super.key, required this.number, required this.color});
  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    //Circle with number
    return Container(
      width: 20,
      height: 37,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.black.withOpacity(.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomText(
        number.toString(),
        textColor: colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
      ),
    );
  }
}
