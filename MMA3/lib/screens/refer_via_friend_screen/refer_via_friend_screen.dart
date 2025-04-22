// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/dynamic_link_handler.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/refer_card.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class ReferViaFriendScreen extends StatefulWidget {
  static String id = 'refer';

  @override
  _ReferViaFriendScreenState createState() => _ReferViaFriendScreenState();
}

class _ReferViaFriendScreenState extends State<ReferViaFriendScreen> {
  static const MethodChannel _channel = const MethodChannel('social_share');

  final ScalerConfig scaler = Get.find(tag: 'scaler');

  static Future<String> shareSms(String message, {String? url}) async {
    Map<String, dynamic> args;
    if (url == null) {
      args = <String, dynamic>{
        "message": message,
      };
    } else {
      args = <String, dynamic>{
        "urlLink": Uri.parse(url).toString(),
      };
    }
    final String version = await _channel.invokeMethod('shareSms', args);
    return version;
  }

  final String text =
      'This might interest you. I’m learning MMA faster with MMA Flash Cards. Try it for free.';
  // "Spread the word about MMA Flash Cards and earn 10% on each paid membership that you refer.";
  openwhatsapp() async {
    final link = await DynamicLinkHandler.createReferralLink();

    var whatappURLIos =
        "https://wa.me/?text=${Uri.parse("${link + "\n" + text}")}";

    if (await canLaunch(whatappURLIos)) {
      await launch(whatappURLIos, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Refer a friend",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: scaler.scalerH(30.0),
                  vertical: scaler.scalerV(60.0)),
              child: Image.asset(
                "assets/images/refer now.png",
              ),
            ),
            Text(
              "Refer friend via",
              style: textStyle(
                  fontSize: scaler.scalerT(14.0), color: DayTheme.textColor),
            ),
            SizedBox(
              height: scaler.scalerV(35.0),
            ),
            ReferCard(
              image: "assets/images/whatsapp.png",
              icons: Icon(Icons.arrow_forward_ios),
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                if (Platform.isIOS) {
                  openwhatsapp();
                } else {
                  SocialShare.shareWhatsapp("$text\n$link");
                }
                print(link);
              },
              title: "Whatsapp",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
            ReferCard(
              image: "assets/images/gmail.png",
              icons: Icon(Icons.arrow_forward_ios),
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                if (Platform.isIOS) {
                  shareSms(
                    link,
                  );
                } else {
                  shareSms("$text\n$link");
                }

                print(link);
              },
              title: "Message",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
            ReferCard(
              leadingIcon: Icon(Icons.pending_outlined),
              icons: Icon(Icons.arrow_forward_ios),
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                print(link);
                Share.share("$text\n$link");
              },
              title: "More",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
            ReferCard(
              image: "assets/images/link.png",
              color: DayTheme.textColor,
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                print(link);
                SocialShare.copyToClipboard(text: "$text\n$link").then(
                  (value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Referral link copied",
                      style: textStyle(fontWeight: FontWeight.w500),
                    ),
                  )),
                );
              },
              title: "Copy link",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
          ],
        ),
      ),
    );
  }
}
