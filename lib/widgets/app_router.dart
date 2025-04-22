import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/aacount_delete_popup_screen/account_delete_popup-screen.dart';
import 'package:flutter_app/screens/acceptable_use_screen/acceptable_use_screen.dart';
import 'package:flutter_app/screens/browse_cards_screen/browse_cards_screen.dart';
import 'package:flutter_app/screens/cancel_subs_reason_screen/cancel_subs_reason_screen.dart';
import 'package:flutter_app/screens/cancel_subscription_screen%20_/cancel_subscription_screen.dart';
import 'package:flutter_app/screens/card_back_screen/card_back_screen.dart';
import 'package:flutter_app/screens/card_front_screen/card_fronts_screen.dart';
import 'package:flutter_app/screens/category_popup_screen/category_popup_screen.dart';
import 'package:flutter_app/screens/delete_account_screen/delete_account_screen.dart';
import 'package:flutter_app/screens/get_start_screen/get_start.dart';
import 'package:flutter_app/screens/liability_waiver_form/liability_waiver_form.dart';
import 'package:flutter_app/screens/redeem_amzone_popup_screen/redeem_amzone_popup.dart';
import 'package:flutter_app/screens/redeem_fail_popup_screen/redeem_fail_popup.dart';
import 'package:flutter_app/screens/redeem_paypal_popup_screen/redeem_paypal_popup.dart';
import 'package:flutter_app/screens/sm_copyright_screen%20copy/sm_copyright_screen.dart';
import 'package:flutter_app/screens/change_password_screen/change_password_screen.dart';
import 'package:flutter_app/screens/contact_screen/contact_screen.dart';
import 'package:flutter_app/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/screens/otp_screen/otp_screen.dart';
import 'package:flutter_app/screens/password_otp_screen/password_otp_screen.dart';
import 'package:flutter_app/screens/privacy_screen/privacy_screen.dart';
import 'package:flutter_app/screens/profile_otp_scrren/profile_otp_screen.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/screens/refer_friend_screen/refer_friend_screen.dart';
import 'package:flutter_app/screens/refer_via_friend_screen/refer_via_friend_screen.dart';
import 'package:flutter_app/screens/referred_friend_screen/referred_friend_screen.dart';
import 'package:flutter_app/screens/smartmix_card_fronts_screen_/smartmix_card_fronts_screen%20.dart';
import 'package:flutter_app/screens/start_screen/start_screen.dart';
import 'package:flutter_app/screens/subscription_screen/subscription_screens.dart';
import 'package:flutter_app/screens/terms_services_screen/terms_services_screen.dart';

class AppRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityWidgetWrapper(
        child: MaterialApp(
          title: 'MMA',
          theme: ThemeData(
            primaryColor: DayTheme.primaryColor,
            primarySwatch: DayTheme.primaryMaterialColor,
          ),
          initialRoute: HomeScreen.id,
          routes: {
            HomeScreen.id: (context) => Material(
                  child: HomeScreen(),
                ),
            ProfileScreen.id: (context) => Material(
                  child: ProfileScreen(),
                ),
            OtpScreen.id: (context) => Material(
                  child: OtpScreen(),
                ),
            PasswordOtpScreen.id: (context) => Material(
                  child: PasswordOtpScreen(),
                ),
            ProfileOtpScreen.id: (context) => Material(
                  child: ProfileOtpScreen(),
                ),
            EditProfileScreen.id: (context) => Material(
                  child: EditProfileScreen(),
                ),
            CancelSubscriptionScreen.id: (context) => Material(
                  child: CancelSubscriptionScreen(),
                ),
            ChangePasswordScreen.id: (context) => Material(
                  child: ChangePasswordScreen(),
                ),
            ReferFriendScreen.id: (context) => Material(
                  child: ReferFriendScreen(),
                ),
            ReferViaFriendScreen.id: (context) => Material(
                  child: ReferViaFriendScreen(),
                ),
            TermsServiesScreen.id: (context) => Material(
                  child: TermsServiesScreen(),
                ),
            PrivacyScreen.id: (context) => Material(
                  child: PrivacyScreen(),
                ),
            SubscriptionScreen.id: (context) => Material(
                  child: SubscriptionScreen(),
                ),
            ContactScreen.id: (context) => Material(
                  child: ContactScreen(),
                ),
            CancelSubsReasonScreen.id: (context) => Material(
                  child: CancelSubsReasonScreen(),
                ),
            ReferredFriendScreen.id: (context) => Material(
                  child: ReferredFriendScreen(),
                ),
            MentalPracticeScreen.id: (context) => Material(
                  child: MentalPracticeScreen(),
                ),
            StartScreen.id: (context) => Material(
                  child: StartScreen(),
                ),
            BrowseCardScreen.id: (context) => Material(
                  child: BrowseCardScreen(),
                ),
            CardBack.id: (context) => Material(
                  child: CardBack(),
                ),
            CardFronts.id: (context) => Material(
                  child: CardFronts(),
                ),
            SmartMixCardFronts.id: (context) => Material(
                  child: SmartMixCardFronts(),
                ),
            CategoryPopupScreen.id: (context) => Material(
                  child: CategoryPopupScreen(),
                ),
            AcceptableUseScreen.id: (context) => Material(
                  child: AcceptableUseScreen(),
                ),
            LiabilityWaiverScreen.id: (context) => Material(
                  child: LiabilityWaiverScreen(),
                ),
            RedeemFailPopupScreen.id: (context) => Material(
                  child: RedeemFailPopupScreen(),
                ),
            RedeemPaypalPopupScreen.id: (context) => Material(
                  child: RedeemPaypalPopupScreen(),
                ),
            RedeemAmzonePopupScreen.id: (context) => Material(
                  child: RedeemAmzonePopupScreen(),
                ),
            GetStartedScreen.id: (context) => Material(
                  child: GetStartedScreen(),
                ),
            SmCopyRightScreen.id: (context) => Material(
                  child: SmCopyRightScreen(),
                ),
            DeleteAccount.id: (context) => Material(
                  child: DeleteAccount(),
                ),
            AccountDeleteScreen.id: (context) => Material(
                  child: AccountDeleteScreen(),
                ),
          },
        ),
      ),
    );
  }
}
