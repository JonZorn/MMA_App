import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/controllers/contact_controller.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContactScreen extends StatefulHookWidget {
  static const String id = 'contact';

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  final ContactController contactController =
      Get.find(tag: 'contact_controller');

  final AuthController authController = Get.find(tag: 'auth_controller');

  final _formKey = GlobalKey<FormState>();

  final FocusNode subjectNode = FocusNode();

  final FocusNode messageNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final subject = useState("");
    final message = useState("");
    showPopup() {
      popupDialog(
        context,
        text: "Message Sent Successfully",
        onTap: () {
          Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.id));
        },
        popOnce: true,
      );
    }

    submit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.reset();

        contactController.contactUs(
            name: authController.user().name!,
            subject: subject.value,
            message: message.value,
            onSuccess: showPopup);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Contact Us",
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(scaler.scalerH(20.0),
              scaler.scalerV(50.0), scaler.scalerH(20.0), 0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                Input(
                  maxLength: 30,
                  labelText: 'Subject',
                  initialValue: subject.value,
                  onChanged: (String text) {
                    subject.value = text;
                  },
                  validator: (value) => Helpers.validateEmpty(
                    value,
                    "Subject",
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    subjectNode.unfocus();
                    messageNode.requestFocus();
                  },
                  focusNode: subjectNode,
                  onTap: () {},
                ),
                SizedBox(
                  height: scaler.scalerV(10.0),
                ),
                TextFormField(
                  maxLength: 1000,
                  style: textStyle(
                    fontSize: scaler.scalerT(15.0),
                    fontWeight: FontWeight.w600,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                    counterText: "",
                    alignLabelWithHint: true,
                    labelStyle: textStyle(
                        color: DayTheme.textColor,
                        fontSize: scaler.scalerT(15.0),
                        fontWeight: FontWeight.w500),
                    labelText: "Your message",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: DayTheme.primaryColor,
                      ),
                    ),
                    hoverColor: DayTheme.primaryColor,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: DayTheme.textColor,
                      ),
                    ),
                  ),
                  focusNode: messageNode,
                  initialValue: message.value,
                  onChanged: (value) => message.value = value,
                  validator: (value) => Helpers.validateEmpty(
                    value!,
                    "Message",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0),
                      scaler.scalerV(50.0), scaler.scalerH(25.0), 0),
                  child: Obx(
                    () => Click(
                      text: "SUBMIT",
                      onPressed: submit,
                      loading: contactController.loading.value,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
