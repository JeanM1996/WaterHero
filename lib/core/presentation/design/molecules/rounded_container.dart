import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/tokens/tokens.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;

  const RoundedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        shadowColor: colors.gray,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ));
  }
}
