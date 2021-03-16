import 'package:flutter_application_1/database/pessoas_dao.dart';
import 'package:flutter_application_1/database/tarefas_dao.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(
    path,
    onCreate: (db, version) async {
      /// if the database does not exists
      await db.execute(TarefasDao.tableSQL);
      await db.execute(PessoasDao.tableSQL);
    },
    onDowngrade: onDatabaseDowngradeDelete,
    version: 1,
  );
}
