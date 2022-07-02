import 'package:adf_flutter_sqlite/database/database_sqflite.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await DatabaseSqfLite().openConnection();

    //Modelo via Objeto relacionais (atributos com métodos específicos)
    //
    //
    database.insert('teste', {'nome': 'Elcinho'});
    // database.delete('teste', where: 'nome = ?', whereArgs: ['Elcinho']);
    // database.update('teste', {'nome': 'ELcio Lopes'},
    //     where: 'nome = ?', whereArgs: ['Elcinho']);

    // var result = await database.query('teste');
    // print(result);

    //Modelo via Query
    //
    //
    // database.rawInsert('insert into teste values(null, ?)', ['Thyara']);
    // database.rawUpdate(
    //     'update teste set nome = ? where id ?', ['Yasmim Lopes', 1]);
    // database.rawDelete('delete from teste where id = ?', [1]);

    var result = await database.rawQuery('select * from teste');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(),
    );
  }
}
