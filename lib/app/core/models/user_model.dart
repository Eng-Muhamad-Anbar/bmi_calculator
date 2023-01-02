import 'package:bmi_calculator/app/core/models/record_model.dart';
import 'package:bmi_calculator/app/core/services/database_service.dart';

class User {
  final int userId;
  final String userName;
  final DateTime createdAt;
   List<Record> records;
  
  User(
      {required this.userId,
      required this.userName,
      required this.createdAt,
      required this.records});
  factory User.fromMap(Map<String, dynamic> userMap) {
    int time = int.parse(userMap[DatabaseService.columnCreateAt]); // ms
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return User(
        userId: userMap[DatabaseService.columnId],
        userName: userMap[DatabaseService.columnName],
        records: Record.toList(userMap['records'] ?? []),
        createdAt: dateTime);
  }
  Map<String, dynamic> toMap() {
    int ms = createdAt.millisecondsSinceEpoch;
    return {
      DatabaseService.columnName: userName,
      DatabaseService.columnCreateAt: ms.toString()
    };
  }

  Map<String, dynamic> userToMap() {
    int ms = createdAt.millisecondsSinceEpoch;
    return {
      DatabaseService.columnName: userName,
      DatabaseService.columnCreateAt: ms.toString(),
      DatabaseService.columnId: userId,
      "records": records.map((e) => e.toMap()).toList()
    };
  }
}
