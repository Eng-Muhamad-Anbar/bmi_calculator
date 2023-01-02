// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bmi_calculator/app/core/models/record_model.dart';
import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:get/get.dart';

import 'package:bmi_calculator/app/core/services/database_service.dart';

class RecordController extends GetxController {
  DatabaseService databaseService;
  List<Record> records = <Record>[];
  RecordController({
    required this.databaseService,
  });
  @override
  void onInit() async {
    records = await databaseService.getAllRecords();
    update();
    super.onInit();
  }
}
