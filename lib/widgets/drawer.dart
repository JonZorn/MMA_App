import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/acceptable_use_screen/acceptable_use_screen.dart';
import 'package:flutter_app/screens/contact_screen/contact_screen.dart';
import 'package:flutter_app/screens/get_start_screen/get_start.dart';
import 'package:flutter_app/screens/liability_waiver_form/liability_waiver_form.dart';
import 'package:flutter_app/screens/privacy_screen/privacy_screen.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/screens/refer_friend_screen/refer_friend_screen.dart';
import 'package:flutter_app/screens/sm_copyright_screen%20copy/sm_copyright_screen.dart';
import 'package:flutter_app/screens/terms_services_screen/terms_services_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
// import 'package:package_info/package_info.dart';

class Drawers extends HookWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');
  final InAppReview _inAppReview = InAppReview.instance;

  final String _appStoreId = '1571624494';
  final String _microsoftStoreId = '';

  _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  Future<String> getVersionNumber() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "1.0.1";
  }

  @override
  Widget build(BuildContext context) {
    final status = useState(false);
    return Drawer(
        child: Stack(children: [
      Container(
        height: scaler.scalerV(360.0),
        // child: Image(
        // image: AssetImage("assets/images/sidecurve.png"),
        // fit: BoxFit.fitWidth,
        // ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: scaler.scalerV(25.0),
          width: scaler.scalerH(49.0),
          margin: EdgeInsets.fromLTRB(scaler.scalerH(35.0), 0,
              scaler.scalerH(00.0), scaler.scalerV(30.0)),
          decoration: BoxDecoration(
            color: DayTheme.primaryColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: Center(
              child: FutureBuilder(
            future: getVersionNumber(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                Text(
              'v ${snapshot.hasData ? snapshot.data : "Loading ...."}',
              style:
                  textStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )),
        ),
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Obx(
          () => InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ProfileScreen.id);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(scaler.scalerH(30.0),
                  scaler.scalerV(65.0), 0, scaler.scalerV(03.0)),
              height: scaler.scalerH(73.0),
              width: scaler.scalerH(73.0),
              decoration: BoxDecoration(
                border: Border.all(
                    width: scaler.scalerH(0.2), color: DayTheme.textColor),
                borderRadius: BorderRadius.circular(scaler.scalerH(73.0) / 2),
                image: authController.user.value.getImageUrl() != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            authController.user.value.getImageUrl()))
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/users.png")),
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.fromLTRB(
                scaler.scalerH(30.0),
                scaler.scalerV(0.0),
                scaler.scalerH(80.0),
                scaler.scalerV(60.0)),
            child: FittedBox(
              child: Text(
                authController.user().name == null
                    ? ""
                    : authController.user().name!,
                style: textStyle(
                    fontSize: scaler.scalerT(18.0),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ]),
      Container(
        margin: EdgeInsets.fromLTRB(scaler.scalerH(30.0), scaler.scalerV(140.0),
            0, scaler.scalerV(0.0)),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(scaler.scalerH(00.0),
              scaler.scalerV(110.0), 0, scaler.scalerV(0.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Text('Profile',
                    style: textStyle(
                        color: DayTheme.textColor,
                        fontSize: scaler.scalerT(18.0))),
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).pushNamed(ProfileScreen.id);
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(scaler.scalerH(00.0),
                    scaler.scalerV(13.0), 0, scaler.scalerV(13.0)),
                child: InkWell(
                  child: Text('Contact us',
                      style: textStyle(
                          color: DayTheme.textColor,
                          fontSize: scaler.scalerT(18.0))),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(ContactScreen.id);
                  },
                ),
              ),
              InkWell(
                child: Text('Rate this app',
                    style: textStyle(
                        color: DayTheme.textColor,
                        fontSize: scaler.scalerT(18.0))),
                onTap: () {
                  Navigator.of(context).pop();
                  _openStoreListing();
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(scaler.scalerH(00.0),
                    scaler.scalerV(13.0), 0, scaler.scalerV(13.0)),
                child: InkWell(
                  child: Text('Refer a Friend',
                      style: textStyle(
                          color: DayTheme.textColor,
                          fontSize: scaler.scalerT(18.0))),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).pushNamed(ReferFriendScreen.id);
                  },
                ),
              ),
              InkWell(
                child: Text('Get started',
                    style: textStyle(
                        color: DayTheme.textColor,
                        fontSize: scaler.scalerT(18.0))),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(GetStartedScreen.id);
                },
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    onExpansionChanged: (value) {
                      status.value = value;
                    },
                    iconColor: DayTheme.primaryColor,
                    expandedAlignment: Alignment.topLeft,
                    childrenPadding: EdgeInsets.only(left: scaler.scalerH(10)),
                    tilePadding: EdgeInsets.only(right: scaler.scalerH(5)),
                    trailing: status.value
                        ? Icon(Icons.keyboard_arrow_down,
                            size: scaler.scalerV(25),
                            color: DayTheme.primaryColor)
                        : Icon(Icons.arrow_forward_ios,
                            size: scaler.scalerV(15),
                            color: DayTheme.primaryColor),
                    title: Text('Important documents',
                        style: textStyle(
                            color: DayTheme.textColor,
                            fontSize: scaler.scalerT(17.0))),
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: Text('Privacy policy',
                              style: textStyle(
                                  color: DayTheme.textColor,
                                  fontSize: scaler.scalerT(17.0))),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(PrivacyScreen.id);
                          },
                        ),
                      ),
                      SizedBox(height: scaler.scalerV(13)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: Text('Terms of services',
                              style: textStyle(
                                  color: DayTheme.textColor,
                                  fontSize: scaler.scalerT(17.0))),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(TermsServiesScreen.id);
                          },
                        ),
                      ),
                      SizedBox(height: scaler.scalerV(13)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: Text('Liability waiver form',
                              style: textStyle(
                                  color: DayTheme.textColor,
                                  fontSize: scaler.scalerT(17.0))),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(LiabilityWaiverScreen.id);
                          },
                        ),
                      ),
                      SizedBox(height: scaler.scalerV(13)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: Text('Acceptable use policy',
                              style: textStyle(
                                  color: DayTheme.textColor,
                                  fontSize: scaler.scalerT(17.0))),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(AcceptableUseScreen.id);
                          },
                        ),
                      ),
                      SizedBox(height: scaler.scalerV(13)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: Text('SM-2 copyright',
                              style: textStyle(
                                  color: DayTheme.textColor,
                                  fontSize: scaler.scalerT(17.0))),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(SmCopyRightScreen.id);
                          },
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    scaler.scalerH(00.0),
                    status.value ? scaler.scalerV(10.0) : scaler.scalerV(0.0),
                    0,
                    scaler.scalerV(13.0)),
                child: InkWell(
                  child: Text(
                    'Signout',
                    style: textStyle(
                        color: DayTheme.textColor,
                        fontSize: scaler.scalerT(18.0)),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    showAlertDialog(context,
                        title: "Signout",
                        text: "Are you sure you want to signout?",
                        onPressedYes: () {
                      authController.logout();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
