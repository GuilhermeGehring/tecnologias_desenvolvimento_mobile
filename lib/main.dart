import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/app.database.dart';
import 'package:flutter_application_1/models/tarefa.dart';
import 'package:flutter_application_1/screens/tarefa/list.dart';

void main() {
  runApp(TarefaApp());
  // save(Tarefa(6, "descricao", "obs")).then((id) {
  //   findAll().then((tarefas) => debugPrint(tarefas.toString()));
  // });
}

class TarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.blueGrey,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.purple)),
        ),
        home: ListaTarefa());
  }
}
