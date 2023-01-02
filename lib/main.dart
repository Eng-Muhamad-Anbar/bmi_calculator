import 'package:bmi_calculator/app/core/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './app/core/constants/pages.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "BMI Calculator",
        initialBinding: AppBindings(),
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        themeMode: ThemeMode.light,
        getPages: appPages);
  }
}
