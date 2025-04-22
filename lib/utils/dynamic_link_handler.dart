import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class DynamicLinkHandler {
  static Future<String> createReferralLink() async {
    final AuthController authController = Get.find(tag: 'auth_controller');

    print(authController.user.value.myReferralCode);

    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://mmaflash.page.link',
      link: Uri.parse(
          'https://mmaflash.page.link?code=${authController.user.value.myReferralCode}'),
      androidParameters: AndroidParameters(
        packageName: 'com.mma.flash',
      ),
      iosParameters:
          IOSParameters(bundleId: 'com.mma.flash', appStoreId: '1571624494'),
    );

    final ShortDynamicLink dynamicUrl =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return dynamicUrl.shortUrl.toString();
  }

  static void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      _handleDynamicLink(data!);
    }
    FirebaseDynamicLinks.instance.onLink;
    // FirebaseDynamicLinks.instance.onLink(
    //     onSuccess: (PendingDynamicLinkData dynamicLink) async {
    //   _handleDynamicLink(dynamicLink);
    // }, onError: (OnLinkErrorException e) async {
    //   print('onLinkError');
    //   print(e.message);
    // });
  }

  static _handleDynamicLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data.link;

    if (deepLink == null) {
      return;
    }
    print(deepLink);
    if (deepLink.queryParameters['code'] != null) {
      var referralCode = deepLink.queryParameters['code'];
      if (referralCode != null) {
        print("refercode=$referralCode");
        final AuthController authController = Get.find(tag: 'auth_controller');
        authController.referralCode.value = referralCode;
      }
    }
  }
}
