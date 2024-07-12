import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/core/presentation/design/atoms/custom_text.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/features/main/widgets/navbar_bottom/navbar_bottom_controller.dart';
import 'package:waterhero/features/main/widgets/navbar_bottom/navbar_bottom_state.dart';
import 'package:waterhero/localization/generated/lang.dart';

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerNav = ref.read(navbarBottomControllerProvider.notifier);
    final stateNave = ref.watch(navbarBottomControllerProvider);
    return InkWell(
      onTap: () => showMenuContext(context, controllerNav, stateNave),
      child: Container(
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
      ),
    );
  }

  void showMenuContext(
    BuildContext context,
    NavbarBottomController controller,
    NavbarBottomState state,
  ) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final top = offset.dy + renderBox.size.height;
    final left = offset.dx;
    final right = offset.dx;
    final bottom = offset.dy;
    final width = renderBox.size.width;
    final height = renderBox.size.height;
    final position = Rect.fromLTWH(left, top, width, height);
    final rect = RelativeRect.fromRect(
      position,
      Offset.zero & MediaQuery.of(context).size,
    );
    //showMenu
    showMenu(
      context: context,
      position: rect,
      items: [
        PopupMenuItem(
          value: 'change_language',
          child: CustomText(
            //If actual language is spanish show english else show spanish
            Lang.of(context).changeLanguage,
            textColor: colors.black,
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: CustomText(
            Lang.of(context).logOut,
            textColor: colors.black,
          ),
        ),
      ],
    ).then((value) async {
      if (value == 'logout') {
        FirebaseAuth.instance.signOut();
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        context.go('/');
      }
      if (value == 'change_language') {
        //Change language
        controller.setLocale(
          state.locale!.languageCode == 'es' ? 'en' : 'es',
        );
      }
    });
  }
}
