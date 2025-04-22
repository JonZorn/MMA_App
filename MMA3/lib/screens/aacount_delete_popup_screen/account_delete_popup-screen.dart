import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class AccountDeleteScreen extends HookWidget {
  static const String id = 'popup delete';
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Center(
                child: Image.asset(
              "assets/images/checked.png",
            )),
            SizedBox(height: scaler.scalerV(30)),
            Text(
              "Account deleted",
              style: textStyle(
                  fontSize: scaler.scalerT(19), fontWeight: FontWeight.w700),
            ),
            SizedBox(height: scaler.scalerV(30)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(15)),
              child: Text(
                "Your account was deleted successfully.\nAll your data was removed from our services.\nThank you for using MMA FLASHCARDS.",
                style: textStyle(
                    color: DayTheme.textColor,
                    fontSize: scaler.scalerT(15),
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: scaler.scalerH(120),
                  vertical: scaler.scalerV(70)),
              child: Click(
                  text: "OK",
                  onPressed: () {
                    authController.logout();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
