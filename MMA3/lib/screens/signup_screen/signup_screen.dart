import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/models/country.dart';
import 'package:flutter_app/screens/acceptable_use_screen/acceptable_use_screen.dart';
import 'package:flutter_app/screens/liability_waiver_form/liability_waiver_form.dart';
import 'package:flutter_app/screens/login_screen/login_screen.dart';
import 'package:flutter_app/screens/otp_screen/otp_screen.dart';
import 'package:flutter_app/screens/privacy_screen/privacy_screen.dart';
import 'package:flutter_app/screens/terms_services_screen/terms_services_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulHookWidget {
  static const String id = 'signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  final AuthController authController = Get.find(tag: 'auth_controller');

  final _formKey = GlobalKey<FormState>();

  final FocusNode nameNode = FocusNode();

  final FocusNode emailNode = FocusNode();

  final FocusNode passwordNode = FocusNode();

  final FocusNode confirmPasswordNode = FocusNode();

  final FocusNode referalNode = FocusNode();
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    final name = useState("");
    final email = useState("");
    final password = useState("");
    final confirmPassword = useState("");
    final referal = useState(authController.referralCode.value != null
        ? authController.referralCode.value
        : "");
    final sub = useState(true);
    final countryid = useState("1");
    final countries = useState<List<DropdownMenuItem>>([]);
    final countriesLoading = useState<bool>(true);
    final countriesList = useState<List<dynamic>>([]);
    final hidePassword = useState(true);
    final hidePasswords = useState(true);
    useEffect(() {
      (() async {
        try {
          final response = await NetworkClient.get(
            '/countryList',
          );
          List<dynamic> countryList = response.data['data'];
          countriesList.value = countryList;

          countries.value = countryList.map((country) {
            final _country = Country.fromJson(country);
            return DropdownMenuItem(
              child:
                  Text(_country.name == null ? "" : _country.name.toString()),
              value: _country.id.toString(),
            );
          }).toList();
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        } finally {
          countriesLoading.value = false;
        }
      })();
      return () {};
    }, []);

    signUp() {
      if (_formKey.currentState!.validate()) {
        authController.signup(
            email: email.value,
            password: password.value,
            name: name.value,
            countryId: countryid.value,
            referralCode: referal.value,
            isNewsletterSubscribed: sub.value,
            onSuccess: () {
              Navigator.of(context)
                  .pushNamed(OtpScreen.id, arguments: {"email": email.value});
            });
      }
    }

    return Scaffold(
      appBar: authheader(context, text: 'Sign Up'),
      resizeToAvoidBottomInset: false,
      body: countriesLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        scaler.scalerH(25.0),
                        scaler.scalerV(10.0),
                        scaler.scalerH(25.0),
                        scaler.scalerV(20.0)),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: textStyle(fontSize: scaler.scalerT(14.0)),
                              children: [
                                TextSpan(
                                  text: 'No credit card required.\n ',
                                  style: textStyle(
                                    color: DayTheme.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Start your ',
                                  style: textStyle(
                                    color: DayTheme.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'FREE 7-DAY ',
                                  style: textStyle(
                                    fontWeight: FontWeight.w500,
                                    color: DayTheme.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
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
                          Input(
                            maxLength: 20,
                            labelText: 'Enter your name',
                            textCapitalization: TextCapitalization.words,
                            initialValue: name.value,
                            onChanged: (String text) {
                              name.value = text;
                            },
                            validator: (value) => Helpers.validateName(
                              value!,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              nameNode.unfocus();
                              emailNode.requestFocus();
                            },
                            focusNode: nameNode,
                            onTap: () {},
                          ),
                          SizedBox(height: scaler.scalerV(20.0)),
                          Input(
                            labelText: 'Enter email',
                            keyboardtype: TextInputType.emailAddress,
                            initialValue: email.value,
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
                          SizedBox(height: scaler.scalerV(20.0)),
                          Input(
                              icons: hidePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              iconColor: hidePassword.value == false
                                  ? DayTheme.primaryColor
                                  : DayTheme.textColor,
                              onTap: () {
                                hidePassword.value = !hidePassword.value;
                              },
                              obscureText: hidePassword.value,
                              labelText: 'Enter password',
                              initialValue: password.value,
                              onChanged: (String text) {
                                password.value = text;
                              },
                              validator: Helpers.strengthPassword,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                passwordNode.unfocus();
                                confirmPasswordNode.requestFocus();
                              },
                              focusNode: passwordNode),
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
                            labelText: 'Confirm password',
                            initialValue: password.value,
                            onChanged: (String text) {
                              confirmPassword.value = text;
                            },
                            validator: (value) =>
                                Helpers.validateConfirmPassword(
                              value,
                              password.value,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              confirmPasswordNode.unfocus();
                              referalNode.requestFocus();
                            },
                            focusNode: confirmPasswordNode,
                          ),
                          SizedBox(
                            height: scaler.scalerV(20.0),
                          ),
                          Input(
                            labelText: 'Enter referal code, if you have one',
                            initialValue: referal.value,
                            onChanged: (String text) {
                              referal.value = text;
                            },
                            onEditingComplete: () {
                              referalNode.unfocus();
                            },
                            focusNode: referalNode,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: scaler.scalerV(25.0),
                          ),
                          countries.value.length > 0
                              ? DropdownSearch<Country>(
                                  // searchBoxStyle: textStyle(
                                  //   fontSize: scaler.scalerT(14.0),
                                  // ),
                                  // label: "Select Country",
                                  // showSearchBox: true,
                                  // dropdownSearchDecoration: InputDecoration(
                                  //   labelStyle: textStyle(
                                  //       fontSize: scaler.scalerT(14.0),
                                  //       fontWeight: FontWeight.w500),
                                  //   border: UnderlineInputBorder(),
                                  //   contentPadding:
                                  //       EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  // ),
                                  // searchBoxDecoration: InputDecoration(
                                  //   labelText: 'Search Country',
                                  // ),
                                  // mode: Mode.DIALOG,
                                  itemAsString: (item) => item.name!,
                                  // onFind: (String filter) async {
                                  //   var models =
                                  //       countriesList.value.map((country) {
                                  //     return Country.fromJson(country);
                                  //   }).toList();
                                  //   return models;
                                  // },
                                  onChanged: (Country? data) {
                                    countryid.value = data!.id.toString();
                                  },
                                  validator: (item) {
                                    if (item == null)
                                      return "Country is required";
                                    else
                                      return null;
                                  },
                                )
                              : Container(),
                          SizedBox(
                            height: scaler.scalerV(35.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: scaler.scalerH(35)),
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: DayTheme.primaryColor,
                                  value: sub.value,
                                  onChanged: (bool? value) {
                                    sub.value = value!;
                                  },
                                ),
                                Text(
                                  "Receive information, offers,\nand free stuff.",
                                  style: textStyle(
                                    color: DayTheme.textColor,
                                    fontSize: scaler.scalerT(14.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: scaler.scalerV(20.0),
                          ),
                          Text.rich(
                            TextSpan(
                              style: textStyle(
                                  fontSize: scaler.scalerT(12.0),
                                  fontWeight: FontWeight.w400,
                                  color: DayTheme.textColor),
                              children: [
                                TextSpan(
                                  text:
                                      'By continuing you indicate that you agree to ',
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(AcceptableUseScreen.id);
                                    },
                                  text: '\nAcceptable Use Policy,',
                                  style: textStyle(
                                    color: DayTheme.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(LiabilityWaiverScreen.id);
                                    },
                                  text: ' Liability Waiver Form,',
                                  style: textStyle(
                                    color: DayTheme.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(TermsServiesScreen.id);
                                    },
                                  text: '\nTerms of Services',
                                  style: textStyle(
                                    color: DayTheme.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' and ',
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(PrivacyScreen.id);
                                    },
                                  text: 'Privacy Policy',
                                  style: textStyle(
                                    color: DayTheme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                scaler.scalerH(25),
                                scaler.scalerV(25.0),
                                scaler.scalerH(25),
                                scaler.scalerV(20.0)),
                            child: Obx(
                              () => Click(
                                loading: authController.loading.value,
                                text: 'SIGN UP',
                                onPressed: signUp,
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: textStyle(
                                  fontSize: scaler.scalerT(14.0),
                                  color: DayTheme.textColor),
                              children: [
                                TextSpan(text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Login',
                                  style: textStyle(
                                    fontWeight: FontWeight.w600,
                                    color: DayTheme.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(LoginScreen.id);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: scaler.scalerV(15.0),
                  )
                ],
              ),
            ),
    );
  }
}
