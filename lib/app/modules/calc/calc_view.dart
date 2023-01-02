import 'package:bmi_calculator/app/core/widgets/custom_text_field.dart';
import 'package:bmi_calculator/app/core/widgets/state_button.dart';
import 'package:bmi_calculator/app/modules/calc/calc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalcView extends GetView<CalcController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed('/records'),
          child: Icon(Icons.menu),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  myLabel: "Gender",
                  hint: "male - female",
                  myValidator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Gender is required";
                    } else {
                      return null;
                    }
                  },
                  onFieldChanges: (value) {
                    controller.record.gender = value;
                    if (isChanged) {
                      formKey.currentState!.validate();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    textInputType: TextInputType.number,
                    myLabel: "Age     ",
                    hint: "age",
                    myValidator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Age is required";
                      } else {
                        return null;
                      }
                    },
                    onFieldChanges: (value) {
                      controller.record.age = value;
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    unitLabel: "years"),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    textInputType: TextInputType.number,
                    myLabel: "Weight ",
                    hint: "my weight",
                    myValidator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Weight is required";
                      } else {
                        return null;
                      }
                    },
                    onFieldChanges: (value) {
                      controller.record.weight = value;
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    unitLabel: "Kg"),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    textInputType: TextInputType.number,
                    myLabel: "Height ",
                    hint: "my height",
                    myValidator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Height is required";
                      } else {
                        return null;
                      }
                    },
                    onFieldChanges: (value) {
                      controller.record.height = value;
                      if (isChanged) {
                        formKey.currentState!.validate();
                      }
                    },
                    unitLabel: "cm"),
                GetBuilder<CalcController>(
                    id: "calc button",
                    builder: (_) {
                      return StateButton(
                          text: 'calc bmi',
                          isLoading: controller.isLoading,
                          myOnPressed: () {
                            isChanged = true;
                            controller.record.createdAt = DateTime.now();
                            controller.calcBMI(context);
                            if (formKey.currentState!.validate()) {
                              controller.calcBMI(context);
                            }
                          });
                    }),
              ],
            ),
          ),
        ));
  }
}
