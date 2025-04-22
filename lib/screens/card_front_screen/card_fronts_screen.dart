import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/card_back_screen/card_back_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class CardFronts extends HookWidget {
  static const String id = 'frontcards';
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  @override
  Widget build(BuildContext context) {
    dynamic arged = ModalRoute.of(context)!.settings.arguments;
    print(arged['id']);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(context, text: "Do You Remember?"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                scaler.scalerH(00.0),
                scaler.scalerV(50.0),
                scaler.scalerH(00.0),
                scaler.scalerH(0.0)),
            child: Text(
              arged['title'],
              textAlign: TextAlign.center,
              style: textStyle(
                  color: DayTheme.primaryColor,
                  fontSize: scaler.scalerT(32.0),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            arged['Smart Mix'] == 'Smart Mix'
                ? arged['smartmixcategoryname']
                : arged['categoryname'],
            textAlign: TextAlign.center,
            style: textStyle(
              color: DayTheme.textColor,
              fontSize: scaler.scalerT(22.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(scaler.scalerH(45.0),
                scaler.scalerV(150.0), scaler.scalerH(45.0), 0),
            child: Click(
                text: 'SHOW ANSWER',
                onPressed: () {
                  Navigator.of(context).pushNamed(CardBack.id, arguments: {
                    'id': arged['id'],
                    'title': arged['title'],
                    'video': arged['video'],
                    'image': arged['image'],
                    'content': arged['content'],
                    'Smart Mix': arged['Smart Mix'],
                    'categoryname': arged['categoryname'],
                    'type': arged['type'],
                    'typeTitle': arged['typeTitle'],
                    "smartmixcategoryname": arged['smartmixcategoryname']
                  });
                }),
          ),
          SizedBox(
            height: scaler.scalerV(30.0),
          ),
        ],
      ),
    );
  }
}
