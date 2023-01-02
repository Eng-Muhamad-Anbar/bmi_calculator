import 'package:bmi_calculator/app/core/models/record_model.dart';
import 'package:flutter/material.dart';

class CustomRecord extends StatelessWidget {
  final Record record;

  const CustomRecord({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Record.getColor(record.calcBMI()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    record.user!.userName,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    record.age,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    record.gender,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    record.calcBMI().toStringAsFixed(2),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Record.getCategory(Record.getColor(record.calcBMI())),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    record.createdAt.toIso8601String(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
