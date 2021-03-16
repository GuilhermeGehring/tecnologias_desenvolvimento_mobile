import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/pessoa/list.dart';
import 'package:flutter_application_1/screens/tarefa/list.dart';

void main() {
  runApp(TarefaApp());
  // save(Tarefa(6, "descricao", "obs")).then((id) {
  //   findAll().then((tarefas) => debugPrint(tarefas.toString()));
  // });
}

class TarefaApp extends StatelessWidget {
  const TarefaApp({key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.blueGrey,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.purple)),
        ),
        home: MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[ListaTarefa(), ListaPessoa()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pessoas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
