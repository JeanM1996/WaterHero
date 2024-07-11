import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/container_icon.dart';
import 'package:waterhero/core/presentation/design/atoms/custom_text.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';

class NoRoute extends StatelessWidget {
  final String iconPath;
  const NoRoute({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.all(.05),
      child: Column(
        children: [
          Container(
            height: context.height(.75),
            padding: context.all(.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors.whiteGrey.withOpacity(.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ContainerIcon(
                        iconColor: colors.blue,
                        icon: iconPath,
                        color: colors.blue.withOpacity(.05),
                        size: 80),
                    const SizedBox(height: 20),
                    CustomText(
                      "No tienes una ruta asignada",
                      textColor: colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Figtree",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      "Actualmente no puedes realizar ninguna acción en este modulo debido a que no tienes una ruta asignada. Si tienes dudas comunícate con tu administrador.",
                      textColor: colors.gray,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      height: 1.25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
