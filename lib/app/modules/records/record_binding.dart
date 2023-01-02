import 'package:bmi_calculator/app/core/services/database_service.dart';
import 'package:bmi_calculator/app/modules/records/record_controller.dart';
import 'package:get/get.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RecordController(databaseService: Get.find<DatabaseService>()));
  }
}
