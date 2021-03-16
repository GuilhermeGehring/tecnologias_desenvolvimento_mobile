import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/pessoas_dao.dart';
import 'package:flutter_application_1/models/pessoa.dart';
import 'package:flutter_application_1/screens/pessoa/form.dart';

class ListaPessoa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaPessoaState();
  }
}

class ListaPessoaState extends State<ListaPessoa> {
  PessoasDao _dao = new PessoasDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormPessoa();
          }));
          future.then((pessoa) {
            setState(() => {});
          });
        },
      ),
      body: FutureBuilder<List<Pessoa>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                final List<Pessoa> pessoas = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Pessoa pessoa = pessoas[index];
                    return itemPessoa(context, pessoa);
                  },
                  itemCount: pessoas.length,
                );
              }
              break;
          } //switch
          return Text('erro desconhecido.');
        }, //builder
      ),
    );
  }

  Widget itemPessoa(BuildContext context, Pessoa pessoa) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.all(12.0),
            child: Card(
                child: ListTile(
                    leading: Icon(Icons.add_alert),
                    title: Text(pessoa.nome),
                    enabled: true,
                    onTap: () {
                      Timer(Duration(milliseconds: 150), () {
                        final Future future = Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FormPessoa(pessoa: pessoa);
                        }));
                        future.then((pessoa) {
                          setState(() => {});
                        });
                      });
                    }))));
  }
}
