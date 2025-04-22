import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStartedScreen extends StatefulHookWidget {
  static const String id = 'strted';

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

final List<String> images = <String>[
  'assets/images/getfirst.png',
  'assets/images/getsecond.png',
  'assets/images/getthree.png',
  'assets/images/getfour.png',
  'assets/images/getfive.png',
  'assets/images/getsix.png',
];
final List<String> texts = <String>[
  'How it Works',
  'Journey to Mastery',
  'Test Yourself',
  'Improve',
  'Evaluate and Schedule',
  'Explore',
];
final List<String> topdescription = <String>[
  'MMA Flashcards offers two practice modes.      ',
  'The Smart Mix will start you with the basics and build the foundation of your game in a logical progression, eventually progressing into more specialized techniques.',
  'MMA Flashcards will prompt you to recall a technique. Then, you will try to picture it perfectly in your mind or perform it perfectly on a partner.',
  'After you have attempted to recall a technique, check your answer.The understanding screen offers a brief video of the technique that you can pause or slow down. Key details are written below.',
  'Finally, rate your performance.\n\nHow good was your first attempt? Did you picture all the details? Did you perform the technique smoothly?\n\nIf not, select "NEEDS WORK" to schedule a more immediate review. Otherwise, select "MOVE ON" to increase the delay on your next review.',
  'You can also explore techniques as you would in an encyclopaedia.',
];
final List<String> bottomdescription = <String>[
  'Choose Mental Practice to review techniques by creating detailed mental images.\n\nChoose Physical Practice to review techniques on the mat with a partner.\n\nCombining mental and physical practice is called "dual coding" and it creates stronger memories.',
  '.',
  'This type of learning is called “active recall” and has been proven to make stronger memories.',
  "Work to improve your mental image or physical performance. This is called “deliberate practice” and has been proven to make stronger memories.",
  'Challenging yourself to remember skills at increasing intervals is called "spaced repetition" and has been proven to make stronger memories. It also allows you to regularly introduce new techniques while maintaining old ones.',
  "Find any technique that interests you. Select “Needs Work” and it will be added to the front of your Smart Mix."
];

class _GetStartedScreenState extends State<GetStartedScreen> {
  final AuthController authController = Get.find(tag: 'auth_controller');
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Get.put(ScalerConfig(context), tag: 'scaler');
    ScalerConfig scaler = Get.find(tag: 'scaler');

    return Scaffold(
      appBar: header(context, text: "Get Started"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: scaler.scalerV(10.0),
          ),
          Expanded(
            child: PageView.builder(
                onPageChanged: (val) {
                  setState(() {
                    currentIndex = val;
                  });
                },
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (cxt, i) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      Text(
                        texts[i],
                        style: textStyle(
                            fontSize: scaler.scalerT(23.0),
                            color: DayTheme.primaryColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            scaler.scalerH(20.0),
                            scaler.scalerV(10.0),
                            scaler.scalerH(20.0),
                            scaler.scalerV(10.0)),
                        child: Text.rich(
                          TextSpan(
                            style: textStyle(
                                fontSize: scaler.scalerT(15.0),
                                color: DayTheme.textColor),
                            children: [
                              TextSpan(
                                text: topdescription[i],
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   topdescription[i],
                        //   style: textStyle(
                        //       color: DayTheme.textColor,
                        //       fontSize: scaler.scalerT(15.0)),
                        // ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              scaler.scalerH(20.0),
                              scaler.scalerV(5.0),
                              scaler.scalerH(20.0),
                              scaler.scalerV(10.0)),
                          child: Image.asset(
                            images[i],
                            fit: BoxFit.cover,
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(scaler.scalerH(20.0),
                            scaler.scalerV(5.0), scaler.scalerH(20.0), 0),
                        child: Text.rich(
                          TextSpan(
                            style: textStyle(
                                fontSize: scaler.scalerT(15.0),
                                color: DayTheme.textColor),
                            children: [
                              TextSpan(
                                text: bottomdescription[i],
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   bottomdescription[i],
                        //   style: textStyle(
                        //       color: DayTheme.textColor,
                        //       fontSize: scaler.scalerT(16.0)),
                        // ),
                      ),
                    ]),
                  );
                }),
          ),
          SizedBox(
            height: scaler.scalerV(10.0),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: images.length,
            onDotClicked: (int index) {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            effect: SlideEffect(
                spacing: 8.0,
                radius: 8.0,
                dotWidth: 12.0,
                dotHeight: 12.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 0.5,
                dotColor: Colors.grey,
                activeDotColor: Colors.red),
          ),
          currentIndex != images.length - 1
              ? Container(
                  padding: EdgeInsets.fromLTRB(
                      0, scaler.scalerV(00.0), 0, scaler.scalerV(20.0)))
              : Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        scaler.scalerH(60.0),
                        scaler.scalerV(20.0),
                        scaler.scalerH(60.0),
                        scaler.scalerV(20.0)),
                    child: Click(
                      onPressed: () {
                        Navigator.of(context).pushNamed(HomeScreen.id);
                      },
                      text: "Finish".toUpperCase(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
