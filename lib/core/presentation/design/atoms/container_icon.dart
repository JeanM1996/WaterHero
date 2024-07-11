import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContainerIcon extends StatelessWidget {
  const ContainerIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    required this.iconColor,
  });

  final String icon;
  final Color color;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size / 3.8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SvgPicture.asset(
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          icon,
          width: size / 2,
          height: size / 2,
        ),
      ),
    );
  }
}
