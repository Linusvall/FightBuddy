import 'package:mysql1/mysql1.dart';

void main() {
  sqlQuery('David');
}


  
   Future<String> sqlQuery(String userName) async {
    // Open a connection (testdb should already exist)
    final connection = await MySqlConnection.connect(ConnectionSettings(
    host: 'mysql681.loopia.se', 
    port: 3306,
    user: 'fightbud@a337869',
    password: 'fightbuddy',
    db: 'aifboxning_se_db_4'
      ));
    String pass = '';
    Results results = await connection.query('SELECT username, password FROM users WHERE username = "$userName"');
    for (var row in results) {
       pass = ('${row[1]}');
    }

    print(pass);

    // Finally, close the connection
    await connection.close();

    return pass;
    
  }

 


