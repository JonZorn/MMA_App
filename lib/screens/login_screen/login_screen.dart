import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:flutter_app/screens/otp_screen/otp_screen.dart';
import 'package:flutter_app/screens/signup_screen/signup_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulHookWidget {
  static const String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find(tag: 'auth_controller');

  final FocusNode emailNode = FocusNode();

  final FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Get.put(ScalerConfig(context), tag: 'scaler');
    ScalerConfig scaler = Get.find(tag: 'scaler');
    final email = useState("");
    final password = useState("");
    final hidePasswords = useState(true);

    void login() {
      if (_formKey.currentState!.validate()) {
        authController.login(
            email: email.value,
            password: password.value,
            onSuccess: () {
              Navigator.of(context)
                  .pushNamed(OtpScreen.id, arguments: {"email": email.value});
            });
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: scaler.scalerV(100.0),
            ),
            Text('Login',
                style: textStyle(
                    color: DayTheme.primaryColor,
                    fontSize: scaler.scalerT(26.0),
                    fontWeight: FontWeight.w600)),
            Padding(
              padding: EdgeInsets.fromLTRB(scaler.scalerH(21.0),
                  scaler.scalerV(30.0), scaler.scalerH(21.0), 0),
              child: Column(
                children: [
                  // Text(
                  //   'We value our customers and \nNEVER ask for card details to Sign Up.',
                  //   style: textStyle(
                  //     color: DayTheme.textColor,
                  //     fontSize: scaler.scalerT(18.0),
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(
                    height: scaler.scalerV(10.0),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text.rich(
                      TextSpan(
                        style: textStyle(fontSize: scaler.scalerT(16.0)),
                        children: [
                          TextSpan(
                            text: 'Or tap here to start your ',
                            style: textStyle(
                              color: DayTheme.textColor,
                            ),
                          ),
                          TextSpan(
                            text: 'FREE ',
                            style: textStyle(
                              fontWeight: FontWeight.w500,
                              color: DayTheme.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: 'trial',
                            style: textStyle(
                              color: DayTheme.textColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  scaler.scalerH(25.0),
                  scaler.scalerV(48.0),
                  scaler.scalerH(25.0),
                  scaler.scalerV(30.0)),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Input(
                      obscureText: false,
                      labelText: 'Enter email',
                      initialValue: email.value,
                      keyboardtype: TextInputType.emailAddress,
                      onChanged: (String text) {
                        email.value = text;
                      },
                      validator: Helpers.validateEmail,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        emailNode.unfocus();
                        passwordNode.requestFocus();
                      },
                      focusNode: emailNode,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: scaler.scalerV(20.0),
                    ),
                    Input(
                      iconColor: hidePasswords.value == false
                          ? DayTheme.primaryColor
                          : DayTheme.textColor,
                      icons: hidePasswords.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onTap: () {
                        hidePasswords.value = !hidePasswords.value;
                      },
                      obscureText: hidePasswords.value,
                      labelText: 'Enter password',
                      initialValue: password.value,
                      onChanged: (String text) {
                        password.value = text;
                      },
                      validator: (value) => Helpers.validateEmpty(
                        value,
                        "Password",
                      ),
                      onEditingComplete: () {
                        passwordNode.unfocus();
                        login();
                      },
                      focusNode: passwordNode,
                    ),
                    SizedBox(
                      height: scaler.scalerV(30.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text(
                            'Forgot password',
                            style: textStyle(
                                color: DayTheme.primaryColor,
                                fontSize: scaler.scalerT(12.0),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.id);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        scaler.scalerH(25),
                        scaler.scalerV(62.0),
                        scaler.scalerH(25),
                        scaler.scalerV(15.0),
                      ),
                      child: Obx(
                        () => Click(
                          text: 'SIGN IN',
                          onPressed: login,
                          loading: authController.loading.value,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        style: textStyle(fontSize: scaler.scalerT(14.0)),
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: textStyle(
                              color: DayTheme.textColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: textStyle(
                              fontWeight: FontWeight.w500,
                              color: DayTheme.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(SignupScreen.id);
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
