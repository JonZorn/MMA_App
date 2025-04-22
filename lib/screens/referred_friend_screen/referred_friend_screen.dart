import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/models/referal.dart';
import 'package:flutter_app/models/wallet.dart';
import 'package:flutter_app/screens/redeem_amzone_popup_screen/redeem_amzone_popup.dart';
import 'package:flutter_app/screens/redeem_fail_popup_screen/redeem_fail_popup.dart';
import 'package:flutter_app/screens/redeem_paypal_popup_screen/redeem_paypal_popup.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}

class ReferredFriendScreen extends HookWidget {
  static const String id = 'referred';
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    final friendList = useState<List<dynamic>>([]);
    final wallet = useState<dynamic>(Wallet());
    final clickable = useState<bool>(true);
    final friendLoading = useState<bool>(true);
    // final amount = useState("");
    useEffect(() {
      (() async {
        try {
          final response = await NetworkClient.get(
            '/RefferedList',
          );
          List<dynamic> refferedList = response.data['data'];
          friendList.value = refferedList.map((referal) {
            return Referal.fromJson(referal);
          }).toList();
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        }
        try {
          final response = await NetworkClient.get(
            '/getwallet',
          );
          dynamic wallets = response.data['data'];
          if (response.statusCode == 200) {
            if (response.data['data'] != null) {
              wallet.value = Wallet.fromJson(wallets);
            }
          }

          print(response);
          // ignore: unused_catch_clause
        } on DioError catch (e) {
          // NetworkClient.errorHandler(e);
        } finally {
          friendLoading.value = false;
        }
      })();
      return () {};
    }, []);

    print("paypal=${authController.user.value.paypalId}");
    print(wallet.value.currentAmount);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(context, text: "Referred Friends"),
        body: (friendLoading.value)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                      flex: 0,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(top: scaler.scalerH(20)),
                          child: Text(
                            "Lifetime referral earning:",
                            style: textStyle(
                                color: DayTheme.textColor,
                                fontSize: scaler.scalerT(16)),
                          ),
                        ),
                        Text(
                          "\$ ${wallet.value.totalAmount != null ? wallet.value.totalAmount : 0}",
                          style: textStyle(
                              color: DayTheme.primaryColor,
                              fontSize: scaler.scalerT(16)),
                        ),
                        clickable.value
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: scaler.scalerH(10)),
                                    child: Text(
                                      "In your wallet:",
                                      style: textStyle(
                                          color: DayTheme.textColor,
                                          fontSize: scaler.scalerT(16)),
                                    ),
                                  ),
                                  Text(
                                    "\$ ${wallet.value.currentAmount != null ? wallet.value.currentAmount : 0}",
                                    style: textStyle(
                                        color: DayTheme.primaryColor,
                                        fontSize: scaler.scalerT(16)),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: scaler.scalerH(10)),
                                    child: Text(
                                      "Available to redeem:",
                                      style: textStyle(
                                          color: DayTheme.textColor,
                                          fontSize: scaler.scalerT(16)),
                                    ),
                                  ),
                                  Text(
                                    "\$ ${wallet.value.currentAmount != null ? wallet.value.currentAmount : 0}",
                                    style: textStyle(
                                        color: DayTheme.primaryColor,
                                        fontSize: scaler.scalerT(16)),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: scaler.scalerV(8),
                        ),
                        clickable.value
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: scaler.scalerH(55),
                                    vertical: scaler.scalerV(15)),
                                child: Click(
                                    height: scaler.scalerV(53),
                                    color: DayTheme.textColor,
                                    text: "Redeem on reaching \$ 10",
                                    onPressed: () {
                                      wallet.value.currentAmount != null
                                          ? double.parse(wallet
                                                      .value.currentAmount) >
                                                  9.0
                                              ? clickable.value =
                                                  !clickable.value
                                              // ignore: unnecessary_statements
                                              : ""
                                          // ignore: unnecessary_statements
                                          : "";
                                    }),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: scaler.scalerH(60)),
                                    child: Click(
                                        height: scaler.scalerV(53),
                                        color: DayTheme.progressBarColor,
                                        text: "Redeem via Paypal",
                                        onPressed: () {
                                          authController.user.value.paypalId !=
                                                  null
                                              ? authController.redeempaypal(
                                                  paypalId: authController
                                                      .user.value.paypalId,
                                                  onSuccess: () {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                      RedeemPaypalPopupScreen
                                                          .id,
                                                    );
                                                  })
                                              : Navigator.of(context).pushNamed(
                                                  RedeemFailPopupScreen.id,
                                                );
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: scaler.scalerH(30),
                                        vertical: scaler.scalerV(15)),
                                    child: Click(
                                        height: scaler.scalerV(53),
                                        color: DayTheme.progressBarColor,
                                        text: "Redeem via Amazon Gift card",
                                        onPressed: () {
                                          authController.redeemamzone(
                                              amount:
                                                  wallet.value.currentAmount,
                                              onSuccess: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                  RedeemAmzonePopupScreen.id,
                                                );
                                              });
                                        }),
                                  ),
                                ],
                              )
                      ])),
                  (friendList.value.length != 0)
                      ? Expanded(
                          flex: 1,
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  scaler.scalerV(20.0),
                                  0,
                                  scaler.scalerV(20.0)),
                              itemCount: friendList.value.length,
                              itemBuilder: (context, int index) {
                                var myDate = DateTime.tryParse(
                                    friendList.value[index].createdAt);
                                return Container(
                                  child: ListTile(
                                    leading: Container(
                                      height: scaler.scalerH(42.0),
                                      width: scaler.scalerH(42.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            scaler.scalerH(70.0)),
                                        border: Border.all(
                                            width: scaler.scalerH(0.2),
                                            color: DayTheme.textColor),

                                        image: friendList.value[index]
                                                    .getImageUrls() !=
                                                null
                                            ? DecorationImage(
                                                image: NetworkImage(friendList
                                                    .value[index]
                                                    .getImageUrls()))
                                            : DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/users.png"),
                                              ),
                                        // image: DecorationImage(
                                        //   image: friendList.value[index]
                                        //               .getImageUrls() !=
                                        //           null
                                        //       ? NetworkImage(friendList
                                        //           .value[index]
                                        //           .getImageUrls())
                                        //       : AssetImage(
                                        //           "assets/images/users.png"),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                    ),
                                    trailing: Text(
                                      myDate!.isToday()
                                          ? "Today"
                                          : myDate.isYesterday()
                                              ? "Yesterday"
                                              : DateFormat("dd-MM-yyyy")
                                                  .format(myDate),
                                      style: textStyle(
                                          fontSize: scaler.scalerT(12),
                                          color: DayTheme.textColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    title: Text(
                                      friendList.value[index].name,
                                      style: textStyle(
                                          fontSize: scaler.scalerT(15),
                                          color: DayTheme.textColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 4.5),
                          child: Text(
                            "No Referred Friends",
                            style: textStyle(
                                color: DayTheme.textColor,
                                fontSize: scaler.scalerT(15.0)),
                          ),
                        )
                ],
              ));
  }
}
