import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/editor.dart';
import 'package:flutter_application_1/models/tarefa.dart';

class FormTarefa extends StatelessWidget {
  final TextEditingController _controladorCampoDescricao =
      TextEditingController();
  final TextEditingController _controladorCampoObservacao =
      TextEditingController();
  double _value = 60;
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Tarefas'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(_controladorCampoDescricao, 'Tarefa', 'Informe a tarefa',
                  Icons.assessment_sharp),
              Editor(_controladorCampoObservacao, 'Observação',
                  'Informe a observação', Icons.notes),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    elevation: 24,
                    onChanged: (String newValue) {
                      dropdownValue = newValue;
                    },
                    items: <String>['One', 'Two', 'Three', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Slider(
                    value: _value,
                    min: 0,
                    max: 100,
                    divisions: 5,
                    label: _value.round().toString(),
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (double value) {
                      _value = value;
                    },
                  )),
              ButtonTheme(
                  child: RaisedButton(
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        _criarTarefa(context);
                      })),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
            ],
          ),
        ));
  }

  void _criarTarefa(context) {
    print('clicou no confirmar');
    final _tarefaCriada = Tarefa(
        _controladorCampoDescricao.text, _controladorCampoObservacao.text);
    debugPrint('$_tarefaCriada');
    Navigator.pop(context, _tarefaCriada);
  }
}
