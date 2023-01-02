import 'package:bmi_calculator/app/core/services/database_service.dart';
import 'package:bmi_calculator/app/modules/calc/calc_controller.dart';
import 'package:get/get.dart';

class CalcBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalcController(databaseService: Get.find<DatabaseService>()));
  }
}
