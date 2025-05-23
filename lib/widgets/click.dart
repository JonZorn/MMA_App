import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';

class Click extends StatelessWidget {
  final String? text;
  final Function() onPressed;
  final bool? loading;
  final bool? disabled;
  final Color? color, textcolor, colors;
  final BorderSide? borderSide;
  final double? height;
  final double? fontSize;
  final BorderRadiusGeometry? radius;
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final double? width;
  Click(
      {required this.text,
      required this.onPressed,
      this.color,
      this.loading = false,
      this.disabled = false,
      this.textcolor,
      this.borderSide,
      this.height,
      this.fontSize,
      this.radius,
      this.colors,
      this.width});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: borderSide ?? BorderSide.none,
        borderRadius: radius ??
            BorderRadius.circular(
              scaler.scalerV(28.0),
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loading!
              ? SizedBox(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: scaler.scalerT(2.0),
                  ),
                  height: scaler.scalerT(16.0),
                  width: scaler.scalerT(16.0),
                )
              : Container(),
          loading!
              ? SizedBox(
                  width: scaler.scalerT(16.0),
                )
              : Container(),
          Text(
            text.toString(),
            style: textStyle(
                fontSize: fontSize ?? scaler.scalerT(16.0),
                fontWeight: FontWeight.w600,
                color: textcolor ?? Colors.white),
          ),
        ],
      ),
      textColor: Colors.white,
      color: color ?? DayTheme.primaryColor,
      disabledColor: colors ?? Colors.grey,
      onPressed: disabled!
          ? null
          : loading!
              ? null
              : onPressed,
      minWidth: width ?? double.infinity,
      height: height ?? scaler.scalerV(55.0),
    );
  }
}
