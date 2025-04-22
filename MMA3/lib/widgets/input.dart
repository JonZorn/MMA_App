import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';

class Input extends StatelessWidget {
  ScalerConfig scaler = Get.find(tag: 'scaler');

  final labelText, withAsterisk;
  final initialValue;
  final obscureText;
  String? Function(String?)? validator;
  TextInputType? keyboardtype;
  TextCapitalization textCapitalization;
  void Function(String) onChanged;
  void Function() onEditingComplete;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  int? maxLength;
  Function() onTap;
  IconData? icons;
  Color? iconColor;

  Input(
      {required this.labelText,
      this.initialValue,
      this.obscureText = false,
      required this.onChanged,
      this.validator,
      this.keyboardtype,
      this.textCapitalization = TextCapitalization.none,
      required this.onEditingComplete,
      this.textInputAction,
      this.focusNode,
      this.maxLength,
      this.withAsterisk,
      required this.onTap,
      this.icons,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      style: textStyle(
          fontSize: scaler.scalerT(15.0), fontWeight: FontWeight.w600),
      textCapitalization: textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardtype,
      obscureText: obscureText,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorMaxLines: 6,
        suffixIcon: IconButton(
          color: DayTheme.textColor,
          icon: Icon(
            icons,
            color: iconColor,
            size: scaler.scalerV(18),
          ),
          onPressed: onTap,
        ),
        counterText: "",
        labelStyle: textStyle(
            fontSize: scaler.scalerT(14.0), fontWeight: FontWeight.w500),
        label: RichText(
          text: TextSpan(
              style: textStyle(
                  color: DayTheme.textColor,
                  fontSize: scaler.scalerT(14.0),
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(text: labelText),
                TextSpan(
                    text: withAsterisk,
                    style: textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: scaler.scalerT(14.0),
                        color: DayTheme.primaryColor)),
              ]),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DayTheme.primaryColor,
          ),
        ),
        hoverColor: DayTheme.primaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DayTheme.textColor,
          ),
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      focusNode: focusNode,
    );
  }
}
