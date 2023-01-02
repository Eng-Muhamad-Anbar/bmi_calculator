import 'package:bmi_calculator/app/core/models/record_model.dart';
import 'package:bmi_calculator/app/core/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  Database? db;
  static const _databaseName = "local_bmi3.db";
  static const _databaseVersion = 1;
  static const table = 'users';
  static const columnId = 'user_id';
  static const columnName = "name";
  static const columnCreateAt = 'created_at';

  static const recordTable = 'records';
  static const columnRecordId = 'record_id';
  static const columnGender = "gender";
  static const columnAge = 'age';
  static const columnWeight = 'weight';
  static const columnHeight = 'height';

  DatabaseService._internal() {
    initDatabase();
  }
  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database _db, int version) async {
    await _db.execute('''
  CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnName TEXT NOT NULL,
    $columnCreateAt TEXT NOT NULL
  ) 
  ''');
    await _db.execute('''
  CREATE TABLE $recordTable (
    $columnRecordId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnId INTEGER NOT NULL,
    $columnGender TEXT NOT NULL,
    $columnAge TEXT NOT NULL,
    $columnWeight TEXT NOT NULL,
    $columnHeight TEXT NOT NULL,
    $columnCreateAt TEXT NOT NULL,
    FOREIGN KEY ($columnId) REFERENCES $table ($columnId) ON DELETE NO ACTION ON UPDATE NO ACTION
  ) 
  ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    if (db == null) return 0;
    var res = await db!.insert(table, user);
    print("res : $res");
    return res;
  }

  Future<int> insertRecord(Record record) async {
    if (db == null) return 0;
    var res = await db!.insert(recordTable, record.toMap());
    print("res : $res");
    return res;
  }

  Future<User> queryUserByName(String name) async {
    if (db == null) return User.fromMap({});
    var result = await db!.rawQuery('''select $table.* from
         $table where $columnName like '$name' ''');
    print("user : $result");
    return User.fromMap(result[0]);
  }

  Future<List<User>> queryUsersWithRecords() async {
    if (db == null) return [];
    var result = await db!.rawQuery('''select * from $table ''');
    List<User> users = [];
    for (var userMap in result) {
      User user = User.fromMap(userMap);
      var list = await getUserRecords(user.userId);
      user.records = list;
      users.add(user);
    }
    print("users : $users");
    return users;
  }

  Future<List<Record>> getUserRecords(int userId) async {
    if (db == null) return [];
    var result = await db!.rawQuery('''select * from $recordTable
           where $columnId = $userId  ''');

    print("records : $result");
    return result.map((e) => Record.fromMap(e)).toList();
  }

  Future<bool> checkUserIfExists(String name) async {
    if (db == null) return false;
    var result =
        await db!.query(table, where: "$columnName like ?", whereArgs: [name]);
    return result.isNotEmpty;
  }

  Future<List<Record>> getAllRecords() async {
    if (db == null) return [];
    List<Record> records = [];
    var result = await db!.query(recordTable);
    print("getAllRecords : $result");
    for (var recordMap in result) {
      Record record = Record.fromMap(recordMap);
      User user = await queryUserById(record.userId);
      record.user = user;
      records.add(record);
    }
    return records;
  }

  Future<User> queryUserById(int id) async {
    if (db == null) return User.fromMap({});
    var result = await db!.rawQuery('''select * from
         $table where $columnId = $id ''');
    print("user : $result");
    return User.fromMap(result[0]);
  }
}
