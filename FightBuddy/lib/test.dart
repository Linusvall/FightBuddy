import 'package:mysql1/mysql1.dart';

class Test {
  var settings = ConnectionSettings(
  host: 'mysql681.loopia.se', 
  port: 3306,
  user: 'fightbud@a337869',
  password: 'fightbuddy',
  db: 'aifboxning_se_db_4'
  );
  var conn = await MySqlConnection.connect(settings);
  var userId = 1;
  var results = await conn.query('select username from users where id = ?', [userId]);

  for (var row in results) {
    print('Username: ${row[0]}');
  }
}
