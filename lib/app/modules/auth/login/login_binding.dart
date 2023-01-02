import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:bmi_calculator/app/core/services/database_service.dart';

import 'package:bmi_calculator/app/modules/auth/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => LoginController(dataBaseService: Get.find<DatabaseService>()));
  }
}
