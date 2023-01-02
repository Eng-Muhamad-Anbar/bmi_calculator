import 'package:bmi_calculator/app/core/models/record_model.dart';
import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:bmi_calculator/app/core/widgets/custom_record_item.dart';
import 'package:bmi_calculator/app/modules/records/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordView extends GetView<RecordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Records')),
      body: GetBuilder<RecordController>(builder: (_) {
        return ListView.builder(
          itemCount: controller.records.length,
          itemBuilder: (context, index) {
            Record record = controller.records[index];
            return CustomRecord(record: record);
          },
        );
      }),
    );
  }
}
