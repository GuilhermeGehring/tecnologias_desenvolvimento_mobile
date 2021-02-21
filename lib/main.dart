import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/tarefas/lista.dart';

void main() {
  runApp(TarefaApp());
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
