import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/utils/dimens_extension.dart';
import 'package:waterhero/localization/generated/lang.dart';

///
/// Esta clase contiene todos los mensajes de dialogo que se mostrarán dentro de la aplicación
///

class CustomDialogs {
  static dynamic showMessageDialog({
    required BuildContext context,
    String? title,
    String? message,
    bool hasloading = false,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Text(title ?? ''),
              Text(message ?? ''),
            ],
          ),
        );
      },
    ).then((_) {
      /// en caso de que tenga un loading lo cierro tambien
      if (hasloading) {
        Navigator.pop(context);
      }
    });
  }

  static dynamic showLoadingDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  static dynamic showCustomModal({
    required Widget child,
    required BuildContext context,
    required bool isFullScreen,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Stack(
            children: [
              SizedBox(
                width: isFullScreen ? context.width(1) : context.width(.8),
                height: isFullScreen ? context.height(1) : context.height(.8),
                child: Center(
                  child: child,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static dynamic enlargePhoto(String url, BuildContext context) {
    CustomDialogs.showCustomModal(
      isFullScreen: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        child: Image.network(url),
      ),
      context: context,
    );
  }

  static dynamic showCustomModalNoClose({
    required Widget child,
    required BuildContext context,
    required bool isFullScreen,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: isFullScreen ? context.width(1) : context.width(.8),
            height: isFullScreen ? context.height(1) : context.height(.8),
            child: Center(
              child: child,
            ),
          ),
        );
      },
    );
  }

  static dynamic hideLoadingDialog(context) {
    Navigator.pop(context);
  }

  static Future showDinamicDialog({
    required BuildContext context,
    required bool dimisible,
    required Widget child,
    Function? whenComplete,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dimisible,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Material(color: Colors.transparent, child: child);
      },
    ).whenComplete(() {
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  ///show bottom sheet
  static dynamic showBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = false,
    bool hasPadding = false,
    Color color = Colors.white,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      //avpod swipe to dismiss
      enableDrag: false,

      backgroundColor: color,
      isScrollControlled: isScrollControlled,

      builder: (context) {
        return hasPadding
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: child,
              )
            : hasPadding
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: child,
                  )
                : child;
      },
    );
  }

  //
  // ignore: long-parameter-list, reuqireddaaaaaaaaaaa
  // ignore: long-method, required data aaaaaaaa
  static dynamic showCustomToast(
    BuildContext context,
    String message,
    String icon,
    bool isTop,
    ActionLiteral? actionItem,
  ) {
    OverlayEntry? overlayEntry;
    var offsetX = 0;

    final overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: isTop ? null : 70,
        top: isTop
            ? actionItem!.position == null
                ? 90
                : actionItem.position
            : null,
        right: 20,
        left: 20,
        child: Material(
          color: Colors.transparent,
          child: TapRegion(
            onTapOutside: (PointerDownEvent tap) {
              //if toast is active and user tap outside, remove toast
              if (overlayEntry != null && overlayEntry.mounted) {
                overlayEntry.remove();
              }
            },
            child: GestureDetector(
              // Detect horizontal drag gestures
              onHorizontalDragUpdate: (details) {
                offsetX += details.delta.dx.toInt();
              },
              onHorizontalDragEnd: (details) {
                // Dismiss the overlay entry when the drag ends
                if (offsetX.abs() > 100) {
                  overlayEntry!.remove();
                } else {
                  // Reset the position if the drag is not sufficient for dismissal

                  offsetX = 0;
                }
              },

              child: Container(
                decoration: BoxDecoration(
                  color: isTop
                      ? actionItem!.color != null
                          ? actionItem.borderHighlight!
                              //Make pastel this color
                              ? actionItem.color!
                                  .withRed(255)
                                  .withGreen(234)
                                  .withBlue(234)
                              : actionItem.color
                          : colors.blue
                      : colors.darkOverlay,
                  borderRadius: BorderRadius.circular(16),
                  border: actionItem!.borderHighlight!
                      ? Border.fromBorderSide(
                          BorderSide(color: actionItem.color!),
                        )
                      : null,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: isTop ? 13 : 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (icon == '')
                      SizedBox(
                        width: !isTop
                            ? null
                            // ignore: avoid-nested-conditional-expressions, required logic
                            : actionItem.showClose!
                                ? 250
                                : 320,
                        child: CustomText(
                          message,
                          fontSize: actionItem.showClose! ? 16 : 14,
                          fontWeight: FontWeight.w400,
                          height: actionItem.showClose! ? 1 : 1.3,
                          textDecoration: TextDecoration.none,
                          textColor: actionItem.borderHighlight!
                              //dark this color
                              ? actionItem.color!
                              : colors.white,
                        ),
                      )
                    else
                      SizedBox(
                        width: !isTop
                            ? null
                            // ignore: avoid-nested-conditional-expressions, required lo
                            : actionItem.showClose!
                                ? 270
                                : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              margin: const EdgeInsets.only(top: 2),
                              child: SvgPicture.asset(
                                icon,
                                colorFilter: ColorFilter.mode(
                                  actionItem.borderHighlight!
                                      ? actionItem.color!
                                      : colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (actionItem.message1 == null)
                              Expanded(
                                child: CustomText(
                                  message,
                                  textDecoration: TextDecoration.none,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                  textColor: actionItem.borderHighlight!
                                      ? actionItem.color!
                                      : colors.white,
                                ),
                              )
                            else
                              SizedBox(
                                width: 200,
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: actionItem.message1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                        text: actionItem.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                        text: actionItem.message2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    // ignore: unnecessary_null_comparison, is necessary
                    if (actionItem != null)
                      InkWell(
                        onTap: () {
                          actionItem.action();
                          overlayEntry?.remove();
                        },
                        child: CustomText(
                          actionItem.label.toUpperCase(),
                          fontSize: 16,
                          textDecoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          textColor: colors.blue,
                        ),
                      )
                    else
                      Container(),
                    if (actionItem.showClose!)
                      InkWell(
                        onTap: () {
                          overlayEntry?.remove();
                        },
                        child: Icon(
                          Icons.close,
                          color: actionItem.borderHighlight!
                              ? actionItem.color!
                              : colors.white,
                          size: 20,
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);

    Future.delayed(
        Duration(
          seconds: actionItem!.duration == null ? 10 : actionItem.duration!,
        ), () {
      if (overlayEntry?.mounted == true) {
        overlayEntry?.remove();
      }
    });
  }

  // ignore: long-method, required data
  static dynamic modalError(BuildContext context, Function action) {
    CustomDialogs.showBottomSheet(
      context: context,
      child: IntrinsicHeight(
        child: Container(
          padding: context.symetric(.055, .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 19),
              Icon(
                Icons.error,
                color: colors.red,
                size: 40,
              ),
              const SizedBox(height: 19),
              CustomText(
                Lang.of(context).weArePresentingFailures,
                fontSize: 20,
                fontFamily: 'Figtree',
                fontWeight: FontWeight.w700,
                textColor: colors.black,
              ),
              const SizedBox(height: 15),
              CustomText(
                Lang.of(context).weArePresentingFailuresMessage,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
                textColor: colors.black,
              ),
              const SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    semanticsLabel: 'try_again',
                    color: colors.blue,
                    text: Lang.of(context).tryAgain,
                    onPressed: () {
                      action;
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    semanticsLabel: 'back',
                    color: colors.blue,
                    buttonType: ButtonType.secondary,
                    text: Lang.of(context).cancel,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionLiteral {
  ActionLiteral({
    required this.label,
    this.action,
    this.name,
    this.message1,
    this.message2,
    this.color,
    this.showClose = true,
    this.duration,
    this.position,
    this.borderHighlight = false,
  });
  String label;
  dynamic action;
  String? name;
  String? message1;
  String? message2;
  Color? color;
  int? duration;
  bool? showClose;
  double? position;

  bool? borderHighlight;

  //empty
  static ActionLiteral empty() {
    return ActionLiteral(
      label: '',
      position: 120,
    );
  }
}
