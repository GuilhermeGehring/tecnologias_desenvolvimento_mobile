import 'package:flutter_application_1/models/pessoa.dart';
import 'package:sqflite/sqflite.dart';

import 'app.database.dart';

class PessoasDao {
  static const String tableSQL = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_telefone TEXT, '
      '$_cpf TEXT)';

  static const String _tableName = 'pessoas';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _telefone = 'telefone';
  static const String _cpf = 'cpf';

  Future<int> save(Pessoa pessoa) async {
    final Database db = await getDatabase();
    Map<String, dynamic> pessoaMap = toMap(pessoa);
    return db.insert(_tableName, pessoaMap);
  }

  Future<int> update(Pessoa pessoa) async {
    final Database db = await getDatabase();
    Map<String, dynamic> pessoaMap = toMap(pessoa);
    return db.update(_tableName, pessoaMap,
        where: '$_id = ?', whereArgs: [pessoa.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> toMap(Pessoa pessoa) {
    final Map<String, dynamic> pessoaMap = Map();
    pessoaMap[_nome] = pessoa.nome;
    pessoaMap[_telefone] = pessoa.telefone;
    pessoaMap[_cpf] = pessoa.cpf;
    return pessoaMap;
  }

  Future<List<Pessoa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Pessoa> pessoas = toList(result);
    return pessoas;
  }

  List<Pessoa> toList(List<Map<String, dynamic>> result) {
    final List<Pessoa> pessoas = List();
    for (Map<String, dynamic> row in result) {
      final Pessoa pessoa =
          Pessoa(row[_id], row[_nome], row[_telefone], row[_cpf]);
      pessoas.add(pessoa);
    }
    return pessoas;
  }
}
