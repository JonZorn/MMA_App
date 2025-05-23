import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/screens/refer_via_friend_screen/refer_via_friend_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/drawer.dart';
import 'package:flutter_app/widgets/practice_mode.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final int dialogOpen = prefs.getInt('dialog_open') ?? 0;
      if (dialogOpen == 0) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          showDialogHome();
          prefs.setInt("dialog_open", 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ScalerConfig(context), tag: 'scaler');
    ScalerConfig scaler = Get.find(tag: 'scaler');
    final boxWidth =
        MediaQuery.of(context).size.width - scaler.scalerH(26.0) * 2;
    final boxHeight = boxWidth * (173.0 / 324.0);
    DateTime timeBackPressed = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DayTheme.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: Drawers(),
      body: WillPopScope(
        onWillPop: () {
          final differeance = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (differeance >= Duration(seconds: 2)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Press again to exit',
            )));
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).dispose();
            SystemNavigator.pop();
            return Future.value(true);
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: scaler.scalerV(65.0)),
                Text(
                  "Select a Practice Mode",
                  style: textStyle(
                      fontSize: scaler.scalerT(22.0),
                      color: DayTheme.textColor),
                ),
                SizedBox(height: scaler.scalerV(55.0)),
                PracticMode(
                  title: 'Mental Practice'.toUpperCase(),
                  image: Image(
                    colorBlendMode: BlendMode.darken,
                    image: AssetImage('assets/images/mental_practice.png'),
                    width: boxWidth,
                    height: boxHeight,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    //showDialogHome();
                    Navigator.of(context)
                        .pushNamed(MentalPracticeScreen.id, arguments: {
                      'type': 'mental',
                      'typeTitle': "Mental Practice",
                    });
                  },
                ),
                SizedBox(
                  height: scaler.scalerV(36.0),
                ),
                PracticMode(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MentalPracticeScreen.id, arguments: {
                      'type': 'physical',
                      'typeTitle': "Physical Practice",
                    });
                  },
                  title: 'Physical Practice'.toUpperCase(),
                  image: Image(
                    colorBlendMode: BlendMode.darken,
                    image: AssetImage('assets/images/physical_practice.png'),
                    width: boxWidth,
                    height: boxHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: scaler.scalerV(40.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogHome() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(25),
            contentPadding: EdgeInsets.fromLTRB(
                scaler.scalerH(20.0),
                scaler.scalerV(20.0),
                scaler.scalerH(20.0),
                scaler.scalerV(5.0)),
            scrollable: true,
            title: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.clear,
                        color: DayTheme.textColor,
                        size: scaler.scalerV(20.0),
                      ),
                    )),
                Text(
                  'Refer a friend'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: scaler.scalerT(20.0),
                      color: DayTheme.primaryColor),
                ),
              ],
            ),
            content: Column(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/refer_a_friend.png",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: scaler.scalerV(10.0)),
                  child: Text(
                    "The faster your friends learn MMA, the harder they will push you. Everyone wins. Share BJJ MMA Flash Cards.",
                    // "Earn a 10% commission on subscription amount on every referral as long as you and your referred friend both stay subscribed.",
                    style: textStyle(
                        fontSize: scaler.scalerT(16.0),
                        color: DayTheme.textColor),
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(scaler.scalerH(60), 0,
                    scaler.scalerH(60), scaler.scalerH(10)),
                child: Click(
                    color: DayTheme.primaryColor,
                    height: scaler.scalerV(45.0),
                    text: 'REFER A FRIEND',
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, ReferViaFriendScreen.id);
                      Get.to(() => ReferViaFriendScreen(),
                          transition: Transition.zoom);
                    }),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "I'll do later",
                    style: textStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: scaler.scalerT(16.0),
                        color: DayTheme.textColor),
                  ),
                ),
              ),
              SizedBox(
                height: scaler.scalerV(10.0),
              )
            ],
          );
        });
  }
}
