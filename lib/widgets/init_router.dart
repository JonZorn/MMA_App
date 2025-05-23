import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/start_screen/start_screen.dart';

class InitRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityWidgetWrapper(child: MaterialApp(
                title: 'MMA',
                theme: ThemeData(
                  primaryColor: DayTheme.primaryColor,
                  primarySwatch: DayTheme.primaryMaterialColor,
                ),
                initialRoute: StartScreen.id,
                routes: {
                  StartScreen.id: (context) => Material(
                        child: StartScreen(),
                      ),
                },
              )),
    );
  }
}
