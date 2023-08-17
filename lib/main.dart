import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:itsmine_01/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 720),
        builder: (context,child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

            primaryColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        )
    );
  }
}

