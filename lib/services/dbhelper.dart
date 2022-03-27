import 'dart:async';
import 'package:movieapp/model/usermodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper{

  static Database? _db;

  static const String dbName = 'user.db';
  static const String tableUser = 'user';
  static const int version = 1;

  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String password = 'password';

  Future<Database?> get db async {
    if (_db != null){
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbName);
   final db =  await openDatabase(path, version: version, onCreate: _onCreate);
   return db;
  }


  Future _onCreate(Database db, int version) async{
    await db.execute('''CREATE TABLE $tableUser (
         $userId INTEGER PRIMARY KEY, 
         $userName TEXT, 
         $email TEXT,
         $password TEXT 
        )''');
  }

  Future<int?> saveData(UserModel user) async{
    final dbClient = await db;
    final res = await dbClient?.insert(tableUser, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String email, String password) async{
    final dbClient = await db;
    final res = await dbClient!.query("$tableUser WHERE "
    "email = '$email' AND "
    "password = '$password'");

    if (res.isNotEmpty){
      return UserModel.fromMap(res.first);
    }
    return null;
  }

}