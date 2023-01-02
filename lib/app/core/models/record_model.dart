import 'dart:math';

import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:bmi_calculator/app/core/services/database_service.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Record {
  int id;
  int userId;
  String gender;
  String age;
  String weight;
  String height;
  DateTime createdAt;
  User? user;
  Record(
      {required this.id,
      required this.userId,
      required this.gender,
      required this.age,
      required this.weight,
      required this.height,
      required this.createdAt,
      this.user});
  double calcBMI() {
    print("********");
    print(toMap());
    double mater = double.parse(height) / 100;
    double value = (double.parse(weight)) / pow(mater, 2);
    return value;
  }

  factory Record.fromMap(Map<String, dynamic> recordMap) {
    int time = int.parse(recordMap[DatabaseService.columnCreateAt]); // ms
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return Record(
        id: recordMap[DatabaseService.columnRecordId],
        userId: recordMap[DatabaseService.columnId],
        gender: recordMap[DatabaseService.columnGender],
        age: recordMap[DatabaseService.columnAge],
        weight: recordMap[DatabaseService.columnWeight],
        height: recordMap[DatabaseService.columnHeight],
        createdAt: dateTime);
  }
  factory Record.empty() => Record(
      id: 0,
      userId: 0,
      gender: "",
      age: "",
      weight: "",
      height: "",
      createdAt: DateTime.now());
  Map<String, dynamic> toMap() {
    int ms = createdAt.millisecondsSinceEpoch;
    return {
      DatabaseService.columnId: userId,
      DatabaseService.columnGender: gender,
      DatabaseService.columnAge: age,
      DatabaseService.columnWeight: weight,
      DatabaseService.columnHeight: height,
      DatabaseService.columnCreateAt: ms.toString()
    };
  }

  static List<Record> toList(List<Map<String, dynamic>> list) {
    return list.map((e) => Record.fromMap(e)).toList();
  }

  static Color getColor(double bmi) {
    if (bmi < 16.0)
      return Colors.yellowAccent.shade100;
    else if (bmi >= 16.0 && bmi <= 18.4)
      return Colors.yellowAccent.shade200;
    else if (bmi >= 18.5 && bmi <= 24.9)
      return Colors.green;
    else if (bmi >= 25.0 && bmi <= 29.9)
      return Colors.orangeAccent;
    else if (bmi >= 30.0 && bmi <= 34.9)
      return Colors.redAccent.shade100;
    else if (bmi >= 35.0 && bmi <= 39.9)
      return Colors.redAccent.shade200;
    else
      return Colors.redAccent;
  }

  static String getCategory(Color color) {
    if (color == Colors.yellowAccent.shade100)
      return 'Serverely Underweight';
    else if (color == Colors.yellowAccent.shade200)
      return 'Underweight';
    else if (color == Colors.green)
      return 'Normal';
    else if (color == Colors.orangeAccent)
      return 'Overweight';
    else if (color == Colors.redAccent.shade100)
      return 'Moderately Obese';
    else if (color == Colors.redAccent.shade200)
      return 'Serverely Obese';
    else
      return "Morbidly Obese";
  }
}
