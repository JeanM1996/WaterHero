import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/custom_text.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      //glassmorphisim
      decoration: BoxDecoration(
        color: colors.white.withOpacity(.4),
        shape: BoxShape.circle,
      ),
      //  FirebaseAuth.instance
      //CustomText with first letter name
      child: CustomText(
        FirebaseAuth.instance.currentUser?.displayName?.substring(0, 1) ?? '',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        textColor: colors.white,
      ),
    );
  }
}
