import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/redeem_paypal_popup_screen/redeem_paypal_popup.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class RedeemFailPopupScreen extends StatefulHookWidget {
  static const String id = 'fail';

  @override
  State<RedeemFailPopupScreen> createState() => _RedeemFailPopupScreenState();
}

class _RedeemFailPopupScreenState extends State<RedeemFailPopupScreen> {
  final AuthController authController = Get.find(tag: 'auth_controller');

  final FocusNode paypalEmailNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final paypalEmail = useState("");

    redeem() {
      if (_formKey.currentState!.validate()) {
        authController.redeempaypal(
            paypalId: paypalEmail.value,
            onSuccess: () {
              Navigator.of(context).pushNamed(
                RedeemPaypalPopupScreen.id,
              );
            });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: scaler.scalerV(325.0),
          width: scaler.scalerH(295.0),
          child: Card(
            elevation: 30,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: scaler.scalerH(25.0),
                            top: scaler.scalerV(10.0)),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.clear,
                                color: DayTheme.textColor,
                                size: scaler.scalerV(20.0),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: scaler.scalerV(15.0),
                      ),
                      Text(
                        "OOPS!",
                        textAlign: TextAlign.center,
                        style: textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: scaler.scalerT(16),
                            color: DayTheme.textColor),
                      ),
                      SizedBox(
                        height: scaler.scalerV(10.0),
                      ),
                      Text(
                        "Please add your PayPal id",
                        textAlign: TextAlign.center,
                        style: textStyle(
                            fontSize: scaler.scalerT(15),
                            color: DayTheme.textColor),
                      ),
                      SizedBox(
                        height: scaler.scalerV(10.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: scaler.scalerH(45.0)),
                        child: Column(
                          children: [
                            Input(
                              labelText: "Enter PayPal id",
                              initialValue: paypalEmail.value,
                              onChanged: (value) {
                                paypalEmail.value = value;
                              },
                              validator: (value) => Helpers.validateEmpty(
                                value,
                                "Paypal email",
                              ),
                              onEditingComplete: () {
                                paypalEmailNode.unfocus();
                                redeem();
                              },
                              focusNode: paypalEmailNode,
                              onTap: () {},
                            ),
                            SizedBox(
                              height: scaler.scalerV(40.0),
                            ),
                            Click(
                              text: 'SAVE AND REDEEM',
                              onPressed: redeem,
                              height: scaler.scalerV(45.0),
                              fontSize: scaler.scalerT(12.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: scaler.scalerV(30.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
