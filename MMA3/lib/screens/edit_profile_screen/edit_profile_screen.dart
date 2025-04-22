import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/delete_account_screen/delete_account_screen.dart';
import 'package:flutter_app/screens/profile_otp_scrren/profile_otp_screen.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:images_picker/images_picker.dart';

class EditProfileScreen extends StatefulHookWidget {
  static const String id = 'editprofile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController authController = Get.find(tag: 'auth_controller');

  final FocusNode nameNode = FocusNode();

  final FocusNode emailNode = FocusNode();

  final FocusNode paypalemailNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = authController.user();
    final name = useState(user.name);
    final email = useState(user.email);
    final paypalId = useState(user.paypalId);

    var profilePicture = useState(user.getImageUrl());
    final isNewsletterSubscribed = useState(user.isNewsletterSubscribed);

    openGallery() async {
      List<Media>? res = await ImagesPicker.pick(
        count: 1,
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 500,
      );
      print({"path": res![0].path, "size": res[0].size});
      profilePicture.value = res[0].path;
    }

    openCamera() async {
      List<Media>? res = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 500,
      );
      print({"path": res![0].path, "size": res[0].size});
      profilePicture.value = res[0].path;
    }

    selectImage() {
      showAlertDialogImage(
        context,
        title: 'Select Profile Picture',
        onPressedNo: openGallery,
        onPressedYes: openCamera,
        no: "Gallery",
        yes: "Camera",
      );
    }

    save() {
      if (_formKey.currentState!.validate()) {
        authController.editProfile(
            profilePicture: user.getImageUrl() != profilePicture.value
                ? profilePicture.value.toString()
                : null,
            email: email.value!,
            paypalId: paypalId.value,
            name: name.value!,
            isNewsletterSubscribed: isNewsletterSubscribed.value!,
            onSuccess: (navigateToOtp) {
              if (navigateToOtp) {
                Navigator.of(context)
                    .pushReplacementNamed(ProfileOtpScreen.id, arguments: {
                  "email": email.value,
                  "originalEmail": user.email,
                  "name": name.value,
                  "paypal_email": paypalId,
                  "isNewsletterSubscribed": isNewsletterSubscribed.value,
                  ...(user.getImageUrl() != profilePicture.value
                      ? {"profilePicture": profilePicture.value}
                      : {})
                });
              } else {
                popupDialog(context, text: "Profile Update Successful",
                    onTap: () {
                  Navigator.of(context).pushReplacementNamed(ProfileScreen.id);
                });
              }
            });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Edit Profile",
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            scaler.scalerH(25.0),
            0,
            scaler.scalerH(25.0),
            scaler.scalerV(30.0),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        0, scaler.scalerV(30.0), 0, scaler.scalerV(10.0)),
                    height: scaler.scalerH(140.0),
                    width: scaler.scalerH(140.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scaler.scalerH(70.0)),
                      border: Border.all(
                          width: scaler.scalerH(4.5), color: Color(0xFFFFD5D5)),

                      image: profilePicture.value.toString() != null
                          ? profilePicture.value.toString().indexOf("http") ==
                                  -1
                              ? DecorationImage(
                                  image: FileImage(
                                      File(profilePicture.value.toString())))
                              : DecorationImage(
                                  image: NetworkImage(
                                      profilePicture.value.toString()))
                          : DecorationImage(
                              image: AssetImage(
                              "assets/images/users.png",
                            )),
                      // image: DecorationImage(
                      //   image: profilePicture.value.toString() != null
                      //       ? profilePicture.value.indexOf("http") == -1
                      //           ? FileImage(
                      //               File(profilePicture.value.toString()))
                      //           : NetworkImage(profilePicture.value.toString())
                      //       : AssetImage(
                      //           "assets/images/users.png",
                      //         ),
                      //   fit: BoxFit.cover,
                      // ),
                      color: Colors.grey.shade300,
                    ),
                  ),
                  onTap: selectImage,
                ),
                GestureDetector(
                  child: Text(
                    "Change Profile Photo",
                    style: textStyle(),
                  ),
                  onTap: selectImage,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, scaler.scalerV(35.0), 0, scaler.scalerV(30.0)),
                  child: Input(
                    maxLength: 20,
                    obscureText: false,
                    labelText: 'Enter your name',
                    withAsterisk: " *",
                    textCapitalization: TextCapitalization.words,
                    initialValue: name.value,
                    onChanged: (String text) {
                      name.value = text;
                    },
                    validator: (value) => Helpers.validateEmpty(
                      value,
                      "Name",
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      nameNode.unfocus();
                      emailNode.requestFocus();
                    },
                    focusNode: nameNode,
                    onTap: () {},
                  ),
                ),
                Input(
                  onTap: () {},
                  obscureText: false,
                  labelText: 'Enter email',
                  withAsterisk: " *",
                  initialValue: email.value,
                  onChanged: (String text) {
                    email.value = text;
                  },
                  validator: Helpers.validateEmail,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    emailNode.unfocus();
                    paypalemailNode.requestFocus();
                  },
                  focusNode: emailNode,
                ),
                SizedBox(height: scaler.scalerH(20)),
                Input(
                  onTap: () {},
                  obscureText: false,
                  labelText: 'Enter PayPal ID to receive referral commission',
                  initialValue: paypalId.value,
                  onChanged: (String text) {
                    paypalId.value = text;
                  },
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    paypalemailNode.unfocus();
                    save();
                  },
                  focusNode: paypalemailNode,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(scaler.scalerH(50.0),
                      scaler.scalerV(50.0), 0, scaler.scalerV(55.0)),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: DayTheme.primaryColor,
                        value: isNewsletterSubscribed.value,
                        onChanged: (bool? value) {
                          isNewsletterSubscribed.value = value!;
                        },
                      ),
                      Text(
                        "Receive information, offers,\n and free stuff.",
                        style: textStyle(
                          color: DayTheme.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0), 0,
                        scaler.scalerH(25.0), scaler.scalerV(15)),
                    child: Obx(
                      () => Click(
                          loading: authController.loading.value,
                          text: "SAVE",
                          onPressed: save),
                    )),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(DeleteAccount.id);
                  },
                  child: Text(
                    "Delete Your Account",
                    style: textStyle(
                        color: DayTheme.primaryColor,
                        fontSize: scaler.scalerT(16),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: scaler.scalerV(15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
