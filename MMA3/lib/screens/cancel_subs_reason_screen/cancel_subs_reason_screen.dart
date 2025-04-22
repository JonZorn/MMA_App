// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/models/cancellation.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CancelSubsReasonScreen extends StatefulHookWidget {
  static const String id = 'subcancel';

  @override
  State<CancelSubsReasonScreen> createState() => _CancelSubsReasonScreenState();
}

class _CancelSubsReasonScreenState extends State<CancelSubsReasonScreen> {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final _formKey = GlobalKey<FormState>();
  final FocusNode feedbackNode = FocusNode();
  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    final feedback = useState("");
    final reasons = useState<List<DropdownMenuItem>>([]);
    final loading = useState<bool>(true);
    final reasonsList = useState<List<dynamic>>([]);
    final reason = useState(reasons);

    useEffect(() {
      (() async {
        try {
          final response = await NetworkClient.get(
            '/cancel/subscription/reasons',
          );
          List<dynamic> reasonList = response.data['data'];
          reasonsList.value = reasonList;

          reasons.value = reasonList.map((reas) {
            final _reason = Cancellation.fromJson(reas);
            return DropdownMenuItem(
              child: Text(_reason.reason!),
              value: _reason.id.toString(),
            );
          }).toList();
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        } finally {
          loading.value = false;
        }
      })();
      return () {};
    }, []);

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

    cancel() {
      if (_formKey.currentState!.validate()) {
        authController.cancelSubscription(
            reason: reason.value.toString(),
            feedback: feedback.value,
            onSuccess: () {
              _launchURL();
              Navigator.of(context).pushReplacementNamed(HomeScreen.id);
            });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Cancel Subscription",
      ),
      body: loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0),
                  scaler.scalerV(30.0), scaler.scalerH(25.0), 0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    // reasons.value.length > 0
                    // ?
                    DropdownSearch<Cancellation>(
                      // dropDownButton: Image.asset(
                      //   'assets/images/icon.png',
                      //   height: scaler.scalerV(18),
                      //   color: DayTheme.textColor,
                      // ),
                      // mode: Mode.MENU,
                      // label: "Reason for cancellation",
                      // dropdownSearchDecoration: InputDecoration(
                      //   labelStyle: textStyle(
                      //       color: DayTheme.textColor,
                      //       fontSize: scaler.scalerT(14.0),
                      //       fontWeight: FontWeight.w500),
                      //   border: UnderlineInputBorder(),
                      //   contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      // ),
                      itemAsString: (item) => item.reason!,
                      // onFind: (String filter) async {
                      //   var models = reasonsList.value.map((reas) {
                      //     return Cancellation.fromJson(reas);
                      //   }).toList();
                      //   return models;
                      // },
                      validator: (item) {
                        if (item == null)
                          return "Reason is required";
                        else
                          return null;
                      },
                    ),
                    // : Container(),
                    SizedBox(
                      height: scaler.scalerV(30.0),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        feedbackNode.unfocus();
                        cancel();
                      },
                      style: textStyle(
                        fontSize: scaler.scalerT(15.0),
                        fontWeight: FontWeight.w600,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: 5,
                      minLines: 5,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: textStyle(
                            color: MediaQuery.of(context).viewInsets.bottom != 0
                                ? DayTheme.primaryColor
                                : DayTheme.textColor,
                            fontSize: scaler.scalerT(14.0),
                            fontWeight: FontWeight.w500),
                        labelText: "Your feedback",
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
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          scaler.scalerH(25.0),
                          scaler.scalerV(270.0),
                          scaler.scalerH(25.0),
                          scaler.scalerV(10.0)),
                      child: Obx(
                        () => Click(
                          loading: authController.loading.value,
                          text: "Submit & Cancel".toUpperCase(),
                          onPressed: cancel,
                          color: Colors.white,
                          borderSide: BorderSide(
                              width: scaler.scalerV(0.4),
                              color: DayTheme.textColor),
                          textcolor: DayTheme.textColor,
                        ),
                      ),
                    ),
                    Text(
                      "You will be redirected to app\n store for manual cancellation",
                      style: textStyle(
                          fontSize: scaler.scalerT(14),
                          color: DayTheme.textColor),
                    ),
                    SizedBox(
                      height: scaler.scalerV(30.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
