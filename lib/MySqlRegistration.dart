import 'package:mysql1/mysql1.dart';
import 'dart:async';

class MySqlRegistration{

  Future<MySqlConnection> getConnection() async{
    var settings = new ConnectionSettings(
        host: 'localhost',
        user: 'root',
        port: 3306,
        password: 'WongTaoZhe@1234',
        db: 'mydb'
    );
    return await MySqlConnection.connect(settings);
  }
}