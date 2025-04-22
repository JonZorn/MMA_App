import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/referred_friend_screen/referred_friend_screen.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RedeemPaypalPopupScreen extends HookWidget {
  static const String id = 'paypal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: scaler.scalerV(325.0),
          width: scaler.scalerH(310.0),
          child: Card(
            elevation: 30,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: scaler.scalerH(25.0),
                          top: scaler.scalerV(10.0)),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                ReferredFriendScreen.id,
                              );
                            },
                            child: Icon(
                              Icons.clear,
                              color: DayTheme.textColor,
                              size: scaler.scalerV(20.0),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: scaler.scalerV(15.0),
                    ),
                    Text(
                      "Awesome",
                      textAlign: TextAlign.center,
                      style: textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: scaler.scalerT(16),
                          color: DayTheme.textColor),
                    ),
                    SizedBox(
                      height: scaler.scalerV(20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "We will send you money on PayPal soon.",
                        textAlign: TextAlign.center,
                        style: textStyle(
                            fontSize: scaler.scalerT(15),
                            color: DayTheme.textColor),
                      ),
                    ),
                    SizedBox(
                      height: scaler.scalerV(45.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: scaler.scalerH(40.0)),
                      child: Column(
                        children: [
                          Click(
                            text: 'CLOSE',
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                ReferredFriendScreen.id,
                              );
                            },
                            height: scaler.scalerV(45.0),
                            fontSize: scaler.scalerT(12.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scaler.scalerV(30.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
