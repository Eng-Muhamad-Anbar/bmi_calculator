import 'package:bmi_calculator/app/core/services/database_service.dart';
import 'package:bmi_calculator/app/modules/auth/login/login_binding.dart';
import 'package:bmi_calculator/app/modules/auth/login/login_view.dart';
import 'package:bmi_calculator/app/modules/calc/calc_binding.dart';
import 'package:bmi_calculator/app/modules/calc/calc_view.dart';
import 'package:bmi_calculator/app/modules/records/record_binding.dart';
import 'package:bmi_calculator/app/modules/records/record_view.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
  GetPage(name: '/calc', page: ()=>CalcView(),binding: CalcBinding()),
  GetPage(name: '/records', page: ()=>RecordView(),binding: RecordBinding())
];

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseService());
  }
}
