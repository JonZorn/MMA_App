// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/aacount_delete_popup_screen/account_delete_popup-screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DeleteAccount extends StatefulHookWidget {
  static const String id = 'delete';

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    final hidePasswords = useState(true);
    final newPassword = useState('');
    _launchURL() async {
      if (Platform.isIOS) {
        const url = 'https://apps.apple.com/account/subscriptions';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      } else {
        const url =
            'https://play.google.com/store/account/subscriptions?package=com.mma.flash&sku=1571624494';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    }

    dele() {
      authController.deleteAccount(
          userId: authController.user.value.id.toString(),
          password: newPassword.value,
          onSuccess: () {
            Navigator.pushNamed(context, AccountDeleteScreen.id);
          });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Delete Your Account",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(20)),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scaler.scalerV(20)),
                Text(
                  "Confirm Your Account",
                  style: textStyle(
                      fontSize: scaler.scalerT(19),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: scaler.scalerV(20)),
                Text(
                  "We need to make sure that this is your account. Please enter your password to proceed.",
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(15),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: scaler.scalerV(20)),
                Input(
                  // iconColor: hidePasswords.value == false
                  //     ? DayTheme.primaryColor
                  //     : DayTheme.textColor,
                  // icons:
                  //     hidePasswords.value ? Icons.visibility : Icons.visibility_off,
                  // onTap: () {
                  //   hidePasswords.value = !hidePasswords.value;
                  // },
                  obscureText: hidePasswords.value,
                  labelText: 'Enter your password',
                  validator: (value) =>
                      Helpers.validateEmpty(value, "Password"),
                  textInputAction: TextInputAction.next,
                  initialValue: newPassword.value,
                  onChanged: (String text) {
                    newPassword.value = text;
                  },
                  onTap: () {},
                  onEditingComplete: () {},
                ),
                SizedBox(height: scaler.scalerV(40)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(20)),
                  child: Click(
                      text: "Delete Account".toUpperCase(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          !authController.user.value.isSubscribed!
                              ? showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: ((BuildContext context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(22.0))),
                                        content: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: const Color(0xFFFFFF),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(55.0)),
                                            ),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          scaler.scalerV(20)),
                                                  Center(
                                                      child: Image.asset(
                                                    "assets/images/delete.png",
                                                    height: scaler.scalerV(60),
                                                  )),
                                                  SizedBox(
                                                      height:
                                                          scaler.scalerV(25)),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: scaler
                                                                .scalerH(20)),
                                                    child: Text(
                                                      "Are you sure you want to delete your account?\n This action can not be undone.",
                                                      style: textStyle(
                                                          color: DayTheme
                                                              .textColor,
                                                          fontSize: scaler
                                                              .scalerT(14),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          scaler.scalerV(20)),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: scaler
                                                              .scalerH(40)),
                                                      Expanded(
                                                          child: Click(
                                                              height: scaler
                                                                  .scalerV(40),
                                                              text: "Yes",
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                dele();
                                                              })),
                                                      SizedBox(
                                                          width: scaler
                                                              .scalerH(30)),
                                                      Expanded(
                                                          child: Click(
                                                              color: DayTheme
                                                                  .textColor,
                                                              height: scaler
                                                                  .scalerV(40),
                                                              text: "No",
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              })),
                                                      SizedBox(
                                                          width: scaler
                                                              .scalerH(30)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          scaler.scalerV(5)),
                                                ])));
                                  }))
                              : showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: ((BuildContext context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(22.0))),
                                        content: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: const Color(0xFFFFFF),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(55.0)),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    height: scaler.scalerV(25)),
                                                Center(
                                                    child: Image.asset(
                                                  "assets/images/error.png",
                                                  height: scaler.scalerV(60),
                                                )),
                                                SizedBox(
                                                    height: scaler.scalerV(15)),
                                                Text.rich(
                                                  TextSpan(
                                                    style: textStyle(
                                                        fontSize: scaler
                                                            .scalerT(15.0),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            DayTheme.textColor),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Your subscription is active.'),
                                                      TextSpan(
                                                        text: '\nPlease ',
                                                      ),
                                                      TextSpan(
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                _launchURL();
                                                              },
                                                        text: 'click here',
                                                        style: textStyle(
                                                            color: Colors.blue,
                                                            textDecoration:
                                                                TextDecoration
                                                                    .underline),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' to cancel your subscription before you can delete account.',
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                    height: scaler.scalerV(20)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Flexible(
                                                        flex: 2,
                                                        child: Click(
                                                            fontSize: scaler
                                                                .scalerT(13.5),
                                                            height: scaler
                                                                .scalerV(45),
                                                            text: "Delete my account"
                                                                .toUpperCase(),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              dele();
                                                            })),
                                                    SizedBox(
                                                      width: scaler.scalerH(5),
                                                    ),
                                                    Flexible(
                                                        flex: 1,
                                                        child: Click(
                                                            fontSize: scaler
                                                                .scalerT(13.5),
                                                            color: DayTheme
                                                                .textColor,
                                                            height: scaler
                                                                .scalerV(45),
                                                            text: "CLOSE",
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            })),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: scaler.scalerV(5)),
                                              ],
                                            )));
                                  }));
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
