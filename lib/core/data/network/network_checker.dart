import 'dart:io';

import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/tokens.dart';
import 'package:waterhero/core/presentation/utils/custom_dialogs.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/localization/generated/lang.dart';

class NetworkChecker {
  //networkchecker that return a bottomsheet if there is no internet connection
  // ignore: long-method
  static Future<bool> check(BuildContext context) async {
    var resultGeneral = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        resultGeneral = true;
      }
    } on SocketException catch (_) {
      resultGeneral = false;
    }
    if (!resultGeneral) {
      CustomDialogs.showBottomSheet(
        context: context,
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            padding: context.symetric(.055, .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //center line
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: colors.black.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                const SizedBox(height: 19),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      Lang.of(context).noInternet,
                      fontSize: 20,
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w700,
                      textColor: colors.black,
                    ),
                    Icon(
                      Icons.wifi_off,
                      size: 50,
                      color: colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomText(
                  Lang.of(context).noInternetMessage,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  textColor: colors.black,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  semanticsLabel: 'ok',
                  color: colors.blue,
                  text: Lang.of(context).ok,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }
    return resultGeneral;
  }
}
