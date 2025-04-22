import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/cancel_subs_reason_screen/cancel_subs_reason_screen.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class CancelSubscriptionScreen extends HookWidget {
  static const String id = 'cancel';
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Cancel Subscription",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: scaler.scalerH(35),
                right: scaler.scalerH(35),
                top: scaler.scalerV(80.0),
              ),
              child: Text(
                "We are sorry to see you go. We will save your progress data. You can reactivate at any time and continue where you left off, or start over again from the beginning.",
                style: textStyle(
                  fontSize: scaler.scalerT(19.0),
                  color: DayTheme.textColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  scaler.scalerH(48.0),
                  scaler.scalerV(160.0),
                  scaler.scalerH(48.0),
                  scaler.scalerV(35.0)),
              child: Click(
                  text: "CANCEL",
                  textcolor: DayTheme.textColor,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(CancelSubsReasonScreen.id);
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  scaler.scalerH(48.0),
                  scaler.scalerV(0.0),
                  scaler.scalerH(48.0),
                  scaler.scalerV(35.0)),
              child: Click(
                  text: " NO, DON'T CANCEL",
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProfileScreen.id);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
