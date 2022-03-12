import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_dr_brain/pages/patient/patient_doctors/doctors_screen.dart';
import 'package:graduation_dr_brain/pages/registration/identity.dart';

void main() {
  runApp(Identity());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0.0,
              //to control status bar
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.deepPurple,
                  statusBarIconBrightness: Brightness.light
              )
          ),

          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            //selectedItemColor: Colors.

          )

      ),
      // home: Login(),
    );
  }
}

