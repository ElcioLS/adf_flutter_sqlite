import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqfLite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQFLITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath, version: 2,
      onConfigure: (db) async {
        print('onConfigure foi chamado');
        await db.execute('PRAGMA foreign_keys = ON');
      },
      // É chamado somente no momento da cração do banco de dados
      // A primeira ez que o app é carregado
      onCreate: (Database db, int version) {
        print('onCreate chamado');
        final batch = db.batch();
        batch.execute(''' 
            create table teste(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
           ''');

        batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
           ''');

        batch.execute('''
            create table categoria(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
           ''');

        batch.commit();
      },
      // Será chamado sempre que houver uma alteração no version incremental(1 > 2)
      onUpgrade: (Database db, int oldVersion, int version) {
        print('onUpgrade chamado');

        final batch = db.batch();

        if (oldVersion == 1) {
          batch.execute(''' 
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
           ''');

          batch.execute('''
            create table categoria(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
           ''');
        }

        if (oldVersion == 2) {
          batch.execute('''
            create table categoria(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
           ''');

          batch.execute('''
          create table categoria(
            id Integer primary key autoincrement,
            nome varchar(200)
          )
         ''');
        }
        batch.commit();
      },

      // Será chamado sempre que houver uma alteração no version decremental(2 > 1)
      onDowngrade: (Database db, int oldVersion, int version) {
        print('onDowngrade chamado');
        final batch = db.batch();

        if (oldVersion == 3) {
          batch.execute(''' 
            drop table categoria;
           ''');

          batch.commit();
        }
      },
    );
  }
}
