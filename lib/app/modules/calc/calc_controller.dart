import 'dart:math';

import 'package:bmi_calculator/app/core/models/record_model.dart';
import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:bmi_calculator/app/core/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalcController extends GetxController {
  DatabaseService databaseService;
  Record record = Record.empty();
  bool isLoading = false;
  CalcController({required this.databaseService});
  late User user;
  @override
  void onInit() async {
    // TODO: implement onInit
    user = await databaseService.queryUserByName(Get.arguments['name']);
    var list = await databaseService.queryUsersWithRecords();
    print(list.map((e) => e.userToMap()));
    record.userId = user.userId;
    super.onInit();
  }

  calcBMI(BuildContext context) async {
    isLoading = true;
    update(["calc button"]);
    await databaseService.insertRecord(record);
    isLoading = false;
    update(["calc button"]);
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Get.back();
      },
    );

    double value = record.calcBMI();
    Color color = Record.getColor(value);
    String state = Record.getCategory(color);
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Your BMI"),
      content: Text(
          "Your BMI value is : ${value.toStringAsFixed(2)} \n and your state is : $state"),
      backgroundColor: color,
      actions: [
        okButton,
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
