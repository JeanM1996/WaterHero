import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.semanticsLabel,
    super.key,
    this.color,
    this.buttonType = ButtonType.primary,
    this.textColor,
    this.isSmall = false,
    this.icon,
    this.enabled = true,
    this.height,
    this.sufixIcon = false,
    this.hasActionOnDisabled = false,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final bool isSmall;
  final ButtonType buttonType;
  final Widget? icon;
  final bool enabled;
  final double? height;
  final bool? sufixIcon;
  final String semanticsLabel;
  final bool hasActionOnDisabled;

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            _getColor(buttonType == ButtonType.primary),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: _getColor(true)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          minimumSize: buttonType != ButtonType.back
              ? WidgetStateProperty.all(
                  Size(
                    160,
                    isSmall
                        ? 36
                        // ignore: avoid-nested-conditional-expressions, required logic
                        : height == null
                            ? 48
                            : height!,
                  ),
                )
              : WidgetStateProperty.all(const Size(75, 36)),

          /// Color icon
          foregroundColor: WidgetStateProperty.all(
            _getColor(buttonType != ButtonType.primary),
          ),
        ),
      ),
      child: Semantics(
        label: 'btn_$semanticsLabel',
        child: TextButton(
          onPressed: enabled
              ? onPressed
              : hasActionOnDisabled
                  ? onPressed
                  : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: buttonType == ButtonType.back ? 8 : 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  sufixIcon!
                      ? Container()
                      : Row(
                          children: [icon!, const SizedBox(width: 15)],
                        ),
                CustomText(
                  text,
                  textColor:
                      textColor ?? _getColor(buttonType != ButtonType.primary),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                  fontSize: 16,
                ),
                if (icon != null)
                  sufixIcon!
                      ? Row(
                          children: [
                            const SizedBox(width: 15),
                            icon!,
                          ],
                        )
                      : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(bool colored) {
    return (colored
        ? color ?? (enabled ? colors.blue : colors.grey10)
        : enabled
            // ignore: avoid-nested-conditional-expressions, required logic
            ? textColor != null
                ? Colors.transparent
                : colors.white
            : colors.gray);
  }
}

enum ButtonType { primary, secondary, back }
