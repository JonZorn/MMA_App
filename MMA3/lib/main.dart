import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/controllers/contact_controller.dart';
import 'package:flutter_app/widgets/app_router.dart';
import 'package:flutter_app/widgets/auth_router.dart';

import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:get_storage/get_storage.dart';

import 'widgets/init_router.dart';

void main() async {
  // await Future.delayed(Duration(seconds: 5));
  print("-----------main");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  Get.put(AuthController(), tag: 'auth_controller');
  Get.put(ContactController(), tag: 'contact_controller');
  final AuthController authController = Get.find(tag: 'auth_controller');
  await authController.init();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthController authController = Get.find(tag: 'auth_controller');
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    print("----------- App  initState");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ConnectivityAppWrapper(
      app: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<FirebaseApp>(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(body: Center(child: Text("Error")));
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Obx(
                    () => authController.loggedIn.value
                        ? AppRouter()
                        : authController.onboarding.value
                            ? AuthRouter()
                            : InitRouter(),
                  );
                }

                return Scaffold(
                  body: Center(
                    child: Scaffold(body: Center(child: Text("Loading..."))),
                  ),
                );
              })),
    );
  }
}
