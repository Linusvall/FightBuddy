import 'package:mysql1/mysql1.dart';

void main(){
  Test t = Test();
  t.main();
}

class Test {
  Future main() async {
    // Open a connection (testdb should already exist)
    final connection = await MySqlConnection.connect(ConnectionSettings(
    host: 'mysql681.loopia.se', 
    port: 3306,
    user: 'fightbud@a337869',
    password: 'fightbuddy',
    db: 'aifboxning_se_db_4'
    
      ));
    var results = await connection.query('select * from users');
    for (var row in results) {
      print('${row[1]}');
    }

    // Finally, close the connection
    await connection.close();
  }
}
