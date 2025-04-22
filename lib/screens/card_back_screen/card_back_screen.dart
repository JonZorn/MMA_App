import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/back_card_controller.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/screens/smartmix_card_fronts_screen_/smartmix_card_fronts_screen%20.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/video_player.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class CardBack extends StatefulHookWidget {
  static const String id = 'cardback';

  @override
  _CardBackState createState() => _CardBackState();
}

class _CardBackState extends State<CardBack> {
  final BackCardController backController =
      Get.put(BackCardController(), tag: 'back_controller');

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    final cardId = useState(args['id']);
    final practiceType = useState(args['type'] == 'mental' ? 0 : 1);
    // final practiceTypes = useState(args['type']);
    print(cardId.value);
    moveOn() {
      args['Smart Mix'] == 'Smart Mix'
          ? backController.smartMixmoveOn(
              practiceType: practiceType.value.toString(),
              cardId: int.parse(cardId.value.toString()),
              onSuccess:
                  (title, id, video, content, image, smartmixcategoryname) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'smartmixcategoryname': smartmixcategoryname,
                  'Smart Mix': args['Smart Mix'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              },
              onFailure: (error) {
                if (error == null) {
                  showAlertDialogback(context, onPressedYes: () {
                    Navigator.of(context).pushNamed(MentalPracticeScreen.id,
                        arguments: {
                          'type': args['type'],
                          'typeTitle': args['typeTitle']
                        });
                  });
                }
              })
          : backController.categorymoveOn(
              practiceType: practiceType.value.toString(),
              cardId: int.parse(cardId.value.toString()),
              onSuccess: (title, id, video, content, image) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'categoryname': args['categoryname'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              },
              onFailure: (error) {
                if (error == null) {
                  showAlertDialogback(context, onPressedYes: () {
                    Navigator.of(context).pushNamed(MentalPracticeScreen.id,
                        arguments: {
                          'type': args['type'],
                          'typeTitle': args['typeTitle']
                        });
                  });
                }
              });
    }

    needsWork() {
      args['Smart Mix'] == 'Smart Mix'
          ? backController.smartmixwork(
              practiceTypes: practiceType.value,
              cardId: int.parse(cardId.value.toString()),
              onSuccess:
                  (title, id, video, content, image, smartmixcategoryname) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'smartmixcategoryname': smartmixcategoryname,
                  'Smart Mix': args['Smart Mix'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              },
              onFailure: (error) {
                if (error == null) {
                  showAlertDialogback(context, onPressedYes: () {
                    Navigator.of(context).pushNamed(MentalPracticeScreen.id,
                        arguments: {
                          'type': args['type'],
                          'typeTitle': args['typeTitle']
                        });
                  });
                }
              })
          : backController.categorywork(
              practiceTypes: practiceType.value,
              cardId: int.parse(cardId.value.toString()),
              onSuccess: (title, id, video, content, image) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'categoryname': args['categoryname'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              },
              onFailure: (error) {
                if (error == null) {
                  showAlertDialogback(context, onPressedYes: () {
                    Navigator.of(context).pushNamed(MentalPracticeScreen.id,
                        arguments: {
                          'type': args['type'],
                          'typeTitle': args['typeTitle']
                        });
                  });
                }
              });
    }

    final boxWidth =
        MediaQuery.of(context).size.width - scaler.scalerH(26.0) * 2;
    final boxHeight = boxWidth * (182.05 / 324.0);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(
          context,
          text: "Check Understanding",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              scaler.scalerH(25), scaler.scalerV(20.0), scaler.scalerH(25), 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  constraints: BoxConstraints.expand(
                    width: boxWidth,
                    height: boxHeight,
                  ),
                  child: VideoPlayers(video: args['video'])),
              SizedBox(
                height: scaler.scalerV(35.0),
              ),
              Text(
                args['title'],
                style: textStyle(
                    color: DayTheme.primaryColor,
                    fontSize: scaler.scalerT(18),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: scaler.scalerV(5.0),
              ),
              HtmlWidget(
                args['content'],
                textStyle: textStyle(
                    fontSize: scaler.scalerT(16.0), color: DayTheme.textColor),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(
            scaler.scalerH(25),
            scaler.scalerV(50.0),
            scaler.scalerH(25),
            scaler.scalerV(20.0),
          ),
          height: scaler.scalerV(120.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Obx(() => Click(
                      loading: backController.loading.value,
                      text: "NEEDS WORK",
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: scaler.scalerT(12.0),
                      onPressed: needsWork,
                    )),
              ),
              SizedBox(
                width: scaler.scalerH(15),
              ),
              Expanded(
                flex: 1,
                child: Obx(() => Click(
                      loading: backController.isloading.value,
                      text: "MOVE ON",
                      color: DayTheme.progressBarColor,
                      fontSize: scaler.scalerT(12.0),
                      onPressed: moveOn,
                    )),
              )
            ],
          ),
        ));
  }
}
