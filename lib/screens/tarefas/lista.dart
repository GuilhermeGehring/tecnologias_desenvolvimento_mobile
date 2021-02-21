import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/tarefa.dart';
import 'package:flutter_application_1/screens/tarefas/form.dart';

class ItemTarefa extends StatelessWidget {
  final Tarefa _tarefa;

  ItemTarefa(this._tarefa);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.add_alert),
        title: Text(_tarefa.descricao),
        subtitle: Text(_tarefa.obs),
      ),
    );
  }
}

class ListaTarefa extends StatefulWidget {
  final List<Tarefa> _tarefas = List();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTarefaState();
  }
}

class ListaTarefaState extends State<ListaTarefa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              final Future future =
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormTarefa();
              }));
              future.then((tarefa) {
                debugPrint('Chegou no then do future');
                debugPrint('$tarefa');
                if (tarefa != null) {
                  setState(() => widget._tarefas.add(tarefa));
                }
              });
            }),
        body: ListView.builder(
          itemCount: widget._tarefas.length,
          itemBuilder: (context, indice) {
            final tarefa = widget._tarefas[indice];
            return ItemTarefa(tarefa);
          },
        ));
  }
}
