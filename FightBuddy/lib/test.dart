import 'package:mysql1/mysql1.dart';

class Test {

  static Future<void> main() async {
    // Open a connection (testdb should already exist)
    final connection = await MySqlConnection.connect(ConnectionSettings(
      host: 'mysql681.loopia.se', 
      port: 3306,
      user: 'fightbud@a337869',
      password: 'fightbuddy',
      db: 'aifboxning_se_db_4',
    ));
    var results = await connection.query('select * from yourTableName');
    for (var row in results) {
      print('${row[0]}');
    }

    // Finally, close the connection
    await connection.close();
  }
}

