import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/login_screen/login_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class CreatePasswordScreen extends StatefulHookWidget {
  static const String id = 'create';

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  final AuthController authController = Get.find(tag: 'auth_controller');

  final _formKey = GlobalKey<FormState>();

  final FocusNode newPasswordNode = FocusNode();

  final FocusNode confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final newPassword = useState("");
    final confirmPassword = useState("");
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    final hidePassword = useState(true);
    final hidePasswords = useState(true);
    showPopup() {
      popupDialog(
        context,
        text: "Your password has been \n successfully changed.",
        text1: "You can now ",
        text2: "Login",
        onTap: () {
          Navigator.of(context).popUntil(ModalRoute.withName(LoginScreen.id));
        },
      );
    }

    update() {
      if (_formKey.currentState!.validate()) {
        authController.resetPassword(
          password: newPassword.value,
          token: args['token'],
          onSuccess: showPopup,
        );
      }
    }

    return Scaffold(
      appBar: authheader(context, text: ""),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: scaler.scalerV(70.0),
              ),
              Text(
                'Create New Password',
                style: textStyle(
                    color: DayTheme.primaryColor,
                    fontSize: scaler.scalerT(26.0),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: scaler.scalerV(85.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    scaler.scalerH(25.0), 0, scaler.scalerH(25.0), 0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      Input(
                          iconColor: hidePassword.value == false
                              ? DayTheme.primaryColor
                              : DayTheme.textColor,
                          icons: hidePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: () {
                            hidePassword.value = !hidePassword.value;
                          },
                          obscureText: hidePassword.value,
                          labelText: 'Enter new password',
                          initialValue: newPassword.value,
                          onChanged: (String text) {
                            newPassword.value = text;
                          },
                          validator: Helpers.strengthPassword,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            newPasswordNode.unfocus();
                            confirmPasswordNode.requestFocus();
                          },
                          focusNode: newPasswordNode),
                      SizedBox(height: scaler.scalerV(20.0)),
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
                        labelText: 'Confirm new password',
                        initialValue: newPassword.value,
                        onChanged: (String text) {
                          confirmPassword.value = text;
                        },
                        validator: (value) => Helpers.validateConfirmPassword(
                          value,
                          newPassword.value,
                        ),
                        onEditingComplete: () {
                          confirmPasswordNode.unfocus();
                          update();
                        },
                        focusNode: confirmPasswordNode,
                      ),
                      SizedBox(
                        height: scaler.scalerV(110.0),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              scaler.scalerH(25.0), 0, scaler.scalerH(25.0), 0),
                          child: Obx(() => Click(
                                text: 'UPDATE',
                                loading: authController.loading.value,
                                onPressed: update,
                              ))),
                      SizedBox(
                        height: scaler.scalerV(20.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
