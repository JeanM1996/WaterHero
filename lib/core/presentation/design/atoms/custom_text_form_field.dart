import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waterhero/core/presentation/design/atoms/atoms.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/design/tokens/styles.dart';
import 'package:waterhero/core/presentation/utils/text_input_formater.dart';
import 'package:waterhero/core/presentation/utils/text_theme_extension.dart';
import 'package:waterhero/core/presentation/utils/validators.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.label,
    required this.semanticsLabel,
    super.key,
    this.prefixIconPath = '',
    this.controller,
    this.enabled = true,
    this.inputValueType = InputValueType.text,
    this.matchValue,
    this.hintText,
    this.inputFormatters = InputFormaters.noFormat,
    this.externalValidation,
    this.hideError = false,
    this.realTimeValidation = false,
    this.externalErrorTint = false,
    this.externalErrorMessage = '',
    this.prefixText = '',
    this.onEnter,
    this.maxLines = 1,
    this.inputType,
    this.hideLabel = false,
    this.onFocus,
    this.readOnly = false,
    this.suffixIconPath = '',
    this.suffixText = '',
    this.onError,
    this.activateError = false,
    this.suffixAction,
    this.lowerCase = false,
    this.isRequired = true,
  });

  /// Titulo input.
  final String label;

  /// Text controller.
  final TextEditingController? controller;

  /// Whether the form is able to receive user input.
  final bool? enabled;

  /// Tipo de dato que se ingresará en el formulario.
  final InputValueType? inputValueType;

  /// Si es repetición de valor se debe validar.
  final String? matchValue;

  /// HintText del textFormField.
  final String? hintText;

  /// Ubicación icono de prefix;
  final String? prefixIconPath;

  final String? prefixText;

  //suffix
  final String? suffixIconPath;

  final String? suffixText;

  final int? maxLines;

  final InputFormaters? inputFormatters;

  //dont show error message
  final bool hideError;

  final bool externalErrorTint;

  final Function(String)? externalValidation;

  final bool realTimeValidation;

  final String externalErrorMessage;

  //on saved
  final Function(String)? onEnter;

  final TextInputType? inputType;

  final bool hideLabel;

  final Function()? onFocus;

  final bool readOnly;

  //return onError or null
  final Function(bool)? onError;

  final bool? activateError;

  final Widget? suffixAction;

  final bool? lowerCase;

  final String semanticsLabel;
  final bool isRequired;

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  bool? showError;
  String? errorMessage;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    if (widget.activateError ?? false) {
      Future.delayed(
        Duration.zero,
        () => _validateInput(widget.controller?.text ?? ''),
      );
    }

    focusNode.addListener(() {
      if (widget.onFocus != null) {
        if (focusNode.hasFocus) {
          widget.onFocus?.call();
          focusNode.unfocus();
        }
      }
      setState(() {});
    });

    Future.delayed(
      Duration.zero,
      () => {
        _defineObscureTextValue(),
        _addTextControllerListener(),
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.hideLabel)
          CustomText(
            widget.label,
            fontSize: 18,
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
          )
        else
          Container(),
        if (!widget.hideLabel) const SizedBox(height: 10) else Container(),
        Container(
          height: widget.maxLines == 50 ? 112 : 56,
          padding: const EdgeInsets.symmetric(vertical: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.enabled! ? colors.box : colors.grey10,
            borderRadius: BorderRadius.all(
              Radius.circular(widget.maxLines == 50 ? 20 : 50),
            ),
            border: Border.all(
              color: widget.externalErrorTint ? colors.yellow : _accentColor(),
            ),
          ),
          child: _defineWidgetStructure(),
        ),
        if (!widget.hideError) ...[
          if (showError ?? false) ...[
            const SizedBox(height: 4),
            CustomText(
              errorMessage,
              textColor: colors.yellow,
              fontWeight: FontWeight.w400,
            ),
          ],
        ],

        /// Mensaje error
      ],
    );
  }

  Widget _defineWidgetStructure() {
    if (widget.inputValueType == InputValueType.password) {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: _textField(),
          ),
          Expanded(
            child: InkWell(
              // ignore: prefer-extracting-callbacks, required this
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
          ),
        ],
      );
      //only when input isnt empty
    } else if (widget.suffixAction != null) {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: _textField(),
          ),
          Expanded(
            child: widget.suffixAction!,
          ),
        ],
      );
    } else {
      return _textField();
    }
  }

  // ignore: long-method, required logic
  Widget _textField() {
    return Material(
      color: Colors.transparent,
      child: Semantics(
        label: 'tf_${widget.semanticsLabel}',
        child: TextFormField(
          maxLines: widget.maxLines,
          textCapitalization: widget.lowerCase!
              ? TextCapitalization.none
              : TextCapitalization.words,
          inputFormatters: _getInputFormater(widget.inputFormatters!),
          focusNode: focusNode,
          readOnly: widget.readOnly,
          controller: widget.controller,
          validator: (x) => _validateInput(x ?? ''),
          //
          // ignore: prefer-extracting-callbacks
          onChanged: (x) {
            hasText = x.isNotEmpty;
            if (widget.realTimeValidation) {
              final result = _validateInput(x);
              if (result == null) {
                _validateExternal();
                if (showError != null) {
                  _validateInput(x);
                }
              } else {
                _validateExternal();
              }
            } else {
              _validateExternal();
              if (showError != null) {
                _validateInput(x);
              }
            }
          },

          //onEnter
          // ignore: prefer-extracting-callbacks, required logic
          onFieldSubmitted: _keyboardType() == TextInputType.multiline
              ? (x) {}
              : (x) {
                  if (widget.onEnter != null) {
                    widget.onEnter!(x);
                  }
                },
          enabled: widget.enabled,
          textInputAction: _keyboardType() == TextInputType.multiline
              ? TextInputAction.newline
              : TextInputAction.next,
          //color black
          style: TextStyle(
            color: colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelStyle: focusNode.hasFocus ? context.h3() : context.p1(),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(
              16,
              _getTopPadding(),
              16,
              _getBottomPadding(),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 25, maxHeight: 25),
            errorStyle: Styles.textStyle(height: 0, fontSize: .01),
            prefixIcon: _getPrefix(),
            suffixIcon: _getSuffix(),
            hintText: widget.hintText,
          ),
          keyboardType: widget.inputType ?? _keyboardType(),
          obscureText: obscureText,
          cursorHeight: 20,
          cursorColor: colors.blueLight,
        ),
      ),
    );
  }

  dynamic _getPrefix() {
    if (widget.prefixText != '') {
      return Container(
        margin: const EdgeInsets.only(left: 16, top: 2, right: 5),
        child: Text(widget.prefixText!),
      );
    } else if (widget.prefixIconPath != '') {
      return Container(
        margin: const EdgeInsets.only(left: 16, top: 2, right: 5),
        child: SvgPicture.asset(
          widget.prefixIconPath!,
          colorFilter: ColorFilter.mode(colors.grey50, BlendMode.srcIn),
        ),
      );
    }
    return null;
  }

  double _getTopPadding() {
    //prefix a double and sufix another double
    if (_getPrefix() != null) {
      return 0;
    }

    if (_getSuffix() != null) {
      return 5;
    }

    return 0;
  }

  double _getBottomPadding() {
    //prefix a double and sufix another double
    if (_getPrefix() != null) {
      return 10;
    }

    if (_getSuffix() != null) {
      return 5;
    }

    return 10;
  }

  dynamic _getSuffix() {
    if (widget.suffixText != '') {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 16),
        child: Text(widget.suffixText!),
      );
    } else if (widget.suffixIconPath != '') {
      return Container(
        margin: const EdgeInsets.only(top: 15, left: 16),
        child: SvgPicture.asset(
          widget.suffixIconPath!,
          colorFilter: ColorFilter.mode(colors.grey50, BlendMode.srcIn),
        ),
      );
    } else {
      return null;
    }
  }

  Color _accentColor() {
    if (showError ?? false) {
      return colors.orange;
    }
    return focusNode.hasFocus
        ? colors.blueLight
        : colors.shadowBlack.withOpacity(.3);
  }

  dynamic _validateExternal() async {
    if (widget.externalValidation != null) {
      final externalError =
          await widget.externalValidation!(widget.controller!.text) ?? false;
      if (externalError) {
        setState(() {
          errorMessage = widget.externalErrorMessage;
          showError = true;
        });
        return true;
      }
    }
  }

  // ignore: long-method, required logic
  List<TextInputFormatter>? _getInputFormater(InputFormaters formaters) {
    switch (formaters) {
      case InputFormaters.alphanumeric:
        return [TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]*$'))];
      case InputFormaters.numeric:
        return [TextInputFormater(RegExp(r'^[0-9\s]*$'))];
      case InputFormaters.idNumber:
        //11 digitos
        return [TextInputFormater(RegExp(r'^[a-zA-Z0-9\s]{0,20}$'))];
      case InputFormaters.routeName:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s\:\.]{0,25}$')),
        ];
      case InputFormaters.streetName:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]{0,9}$')),
        ];
      case InputFormaters.alias:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]{0,20}$')),
        ];

      case InputFormaters.passportNumber:
        return [TextInputFormater(RegExp(r'^[a-zA-Z0-9\s]{0,15}$'))];

      case InputFormaters.chars2000:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]{0,2000}$')),
        ];
      case InputFormaters.chars50:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]{0,50}$')),
        ];
      case InputFormaters.chars28:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]{0,28}$')),
        ];
      case InputFormaters.chars40:
        return [
          TextInputFormater(RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s\:\.]{0,40}$')),
        ];

      default:
        return [];
    }
  }

  dynamic _defineObscureTextValue() {
    setState(() {
      obscureText = (widget.inputValueType == InputValueType.password);
    });
  }

  // ignore: long-method, required logic
  dynamic _validate(String text) {
    switch (widget.inputValueType) {
      case InputValueType.alphanumeric:
        errorMessage = validateAlphanumeric(text);
        break;
      case InputValueType.alphanumericDot:
        errorMessage = validateAlphanumericDot(text);
        break;
      case InputValueType.email:
        errorMessage = validateEmail(
          text,
          matchValue: widget.matchValue,
          widget.isRequired,
        );
        break;
      case InputValueType.password:
        errorMessage = validatePassword(text, matchValue: widget.matchValue);
        break;

      case InputValueType.phone:
        errorMessage = validatePhone(text, matchValue: widget.matchValue);
        break;
      case InputValueType.document:
        errorMessage = validateDocument(text);
        break;
      case InputValueType.passport:
        errorMessage = validatePassport(text);
        break;
      case InputValueType.street:
        errorMessage = validateStreet(text, matchValue: widget.matchValue);
        break;
      case InputValueType.name:
        errorMessage = validateName(text);
        break;
      case InputValueType.lastname:
        errorMessage = validateLastName(text);
        break;
      case InputValueType.place:
        errorMessage = validatePlace(text);
        break;
      case InputValueType.noMandatory:
        errorMessage = null;
        break;
      case InputValueType.currency:
        errorMessage = validateCurrency(text);
        break;
      case InputValueType.noValidate:
        errorMessage = noValidate2(text);
        break;
      case InputValueType.text:
      case InputValueType.number:
        errorMessage = validateNumber(text, matchValue: widget.matchValue);
        break;
      case InputValueType.percentage:
        errorMessage = validatePercentage(text, matchValue: widget.matchValue);
        break;
      case InputValueType.multiline:
        errorMessage = null;
        break;
      case InputValueType.alphanumeric50:
        errorMessage = validateAlphanumeric50(text);
        break;
      case InputValueType.alphanumeric28:
        errorMessage = validateAlphanumeric28(text);
        break;
      case InputValueType.currencyZero:
        errorMessage = allowCurrencyZero(text);
        break;

      default:
        errorMessage = validateText(text, matchValue: widget.matchValue);
        break;
    }
    showError = errorMessage != null;
    return errorMessage;
  }

  dynamic _addTextControllerListener() {
    if (widget.controller != null) {
      widget.controller!.addListener(() {});
    }
  }

  String? _validateInput(String x) {
    _validate(x);
    widget.onError?.call(errorMessage == null ? false : true);
    setState(() {});
    return errorMessage;
  }

  dynamic _keyboardType() {
    switch (widget.inputValueType) {
      case InputValueType.email:
        return TextInputType.emailAddress;

      ///
      case InputValueType.password:
        return TextInputType.visiblePassword;

      ///
      case InputValueType.phone:
      case InputValueType.number:
        return TextInputType.number;
      case InputValueType.document:
        return TextInputType.text;
      case InputValueType.passport:
        return TextInputType.text;

      ///
      case InputValueType.text:
      case InputValueType.name:
      case InputValueType.multiline:
        return TextInputType.multiline;
      case InputValueType.currency:
        return TextInputType.number;
      case InputValueType.currencyZero:
        return TextInputType.number;
      case InputValueType.percentage:
        return TextInputType.number;
      case InputValueType.noValidate:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }
}

enum InputValueType {
  text,
  number,
  phone,
  email,
  password,
  document,
  passport,
  currency,
  name,
  lastname,
  alphanumeric,
  alphanumericDot,
  street,
  place,
  noMandatory,
  multiline,
  alphanumeric50,
  alphanumeric28,
  noValidate,
  percentage,
  officeName,
  currencyZero
}

enum InputFormaters {
  alphanumeric,
  numeric,
  idNumber,
  routeName,
  streetName,
  alias,
  passportNumber,
  chars2000,
  chars50,
  chars40,
  currency,
  noFormat,
  chars28,
  currencyZero
}
