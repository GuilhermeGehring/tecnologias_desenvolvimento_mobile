import 'package:flutter_application_1/models/tarefa.dart';
import 'package:sqflite/sqflite.dart';

import 'app.database.dart';

class TarefasDao {
  static const String tableSQL = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_descricao TEXT, '
      '$_obs TEXT)';

  static const String _tableName = 'tarefas';
  static const String _id = 'id';
  static const String _descricao = 'descricao';
  static const String _obs = 'obs';

  Future<int> save(Tarefa tarefa) async {
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.insert(_tableName, tarefaMap);
  }

  Future<int> update(Tarefa tarefa) async {
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.update(_tableName, tarefaMap,
        where: '$_id = ?', whereArgs: [tarefa.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> toMap(Tarefa tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap[_descricao] = tarefa.descricao;
    tarefaMap[_obs] = tarefa.obs;
    return tarefaMap;
  }

  Future<List<Tarefa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Tarefa> tarefas = toList(result);
    return tarefas;
  }

  List<Tarefa> toList(List<Map<String, dynamic>> result) {
    final List<Tarefa> tarefas = List();
    for (Map<String, dynamic> row in result) {
      final Tarefa tarefa = Tarefa(
        row[_id],
        row[_descricao],
        row[_obs],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }
}
