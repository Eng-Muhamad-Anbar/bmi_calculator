import 'dart:developer';

import 'package:bmi_calculator/app/core/widgets/custom_text_field.dart';
import 'package:bmi_calculator/app/core/widgets/state_button.dart';
import 'package:bmi_calculator/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ListView(
          children: [
            Image.asset(
              "assets/images/bmi.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: CustomTextField(
                myLabel: "Please Enter Your Name: ",
                hint: "My Name",
                myValidator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Username is required";
                  } else {
                    return null;
                  }
                },
                onFieldChanges: (text) {
                  controller.username = text;
                  if (isChanged) {
                    formKey.currentState!.validate();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: GetBuilder<LoginController>(
                      id: "LoginButton",
                      builder: (_) {
                        return StateButton(
                          text: "Login",
                          isLoading: controller.isLoading,
                          myOnPressed: () {
                            isChanged = true;
                            if (formKey.currentState!.validate()) {
                              controller.login();
                            } else {
                              log("Error from validate");
                            }
                          },
                        );
                      }),
                ),
              ],
            ),
            GetBuilder<LoginController>(
                id: "TextError",
                builder: (_) {
                  return Text(
                    "",
                    style:
                        const TextStyle(color: Color.fromARGB(255, 228, 4, 4)),
                  );
                })
          ],
        ),
      ),
    );
  }
}
