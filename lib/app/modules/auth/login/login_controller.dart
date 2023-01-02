import 'dart:developer';

import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:bmi_calculator/app/core/services/database_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  DatabaseService dataBaseService;
  String username = "";
  bool isLoading = false;

  LoginController({required this.dataBaseService});
  Future<void> login() async {
    isLoading = true;
    update(["LoginButton", "TextError"]);
    bool isExists = await dataBaseService.checkUserIfExists(username);
    if (!isExists) {
      await dataBaseService.insertUser({
        DatabaseService.columnName: username,
        DatabaseService.columnCreateAt:
            DateTime.now().millisecondsSinceEpoch.toString()
      });
    }
    Get.offAllNamed("/calc", arguments: {"name": username});
    isLoading = false;
  }
}
