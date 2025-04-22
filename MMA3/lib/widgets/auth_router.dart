import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/aacount_delete_popup_screen/account_delete_popup-screen.dart';
import 'package:flutter_app/screens/acceptable_use_screen/acceptable_use_screen.dart';
import 'package:flutter_app/screens/create_password_screen/create_password_screen.dart';
import 'package:flutter_app/screens/delete_account_screen/delete_account_screen.dart';
import 'package:flutter_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:flutter_app/screens/liability_waiver_form/liability_waiver_form.dart';
import 'package:flutter_app/screens/login_screen/login_screen.dart';
import 'package:flutter_app/screens/otp_screen/otp_screen.dart';
import 'package:flutter_app/screens/password_otp_screen/password_otp_screen.dart';
import 'package:flutter_app/screens/privacy_screen/privacy_screen.dart';
import 'package:flutter_app/screens/profile_otp_scrren/profile_otp_screen.dart';
import 'package:flutter_app/screens/signup_screen/signup_screen.dart';
import 'package:flutter_app/screens/start_screen/start_screen.dart';
import 'package:flutter_app/screens/terms_services_screen/terms_services_screen.dart';

class AuthRouter extends StatelessWidget {
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
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => Material(
                child: LoginScreen(),
              ),
          SignupScreen.id: (context) => Material(
                child: SignupScreen(),
              ),
          ForgotPasswordScreen.id: (context) => Material(
                child: ForgotPasswordScreen(),
              ),
          CreatePasswordScreen.id: (context) => Material(
                child: CreatePasswordScreen(),
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
          TermsServiesScreen.id: (context) => Material(
                child: TermsServiesScreen(),
              ),
          PrivacyScreen.id: (context) => Material(
                child: PrivacyScreen(),
              ),
          StartScreen.id: (context) => Material(
                child: StartScreen(),
              ),
          AcceptableUseScreen.id: (context) => Material(
                child: AcceptableUseScreen(),
              ),
          LiabilityWaiverScreen.id: (context) => Material(
                child: LiabilityWaiverScreen(),
              ),
          DeleteAccount.id: (context) => Material(
                child: DeleteAccount(),
              ),
          AccountDeleteScreen.id: (context) => Material(
                child: AccountDeleteScreen(),
              ),
        },
      )),
    );
  }
}
