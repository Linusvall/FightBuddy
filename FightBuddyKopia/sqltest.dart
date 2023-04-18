import 'dart:ffi';

import 'package:mysql1/mysql1.dart';

void main() {}

Future<bool> sqlLogin(String? userName, password) async {
  // Open a connection (testdb should already exist)
  final connection = await MySqlConnection.connect(ConnectionSettings(
      host: 'mysql681.loopia.se',
      port: 3306,
      user: 'fightbud@a337869',
      password: 'fightbuddy',
      db: 'aifboxning_se_db_4'));

  Results results = await connection.query(
      'SELECT * FROM users WHERE username = "$userName" AND password = "$password"');
  // for (var row in results) {
  //   pass = ('${row[1]}');
  // }s
  await connection.close();

  if (results.isNotEmpty) {
    print(results);
    return true;
  } else {
    print('Wrong username or password');
    return false;
  }

  // Finally, close the connection
}

Future sqlInsert(String userName, password) async {
  // Open a connection (testdb should already exist)
  final connection = await MySqlConnection.connect(ConnectionSettings(
      host: 'mysql681.loopia.se',
      port: 3306,
      user: 'fightbud@a337869',
      password: 'fightbuddy',
      db: 'aifboxning_se_db_4'));

  Results results = await connection.query(
      'INSERT INTO users (username, password) VALUES("$userName", "$password")');

  // Finally, close the connection
  await connection.close();
}
