import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/editor.dart';
import 'package:flutter_application_1/database/pessoas_dao.dart';
import 'package:flutter_application_1/models/pessoa.dart';

class FormPessoa extends StatefulWidget {
  final Pessoa pessoa;

  FormPessoa({this.pessoa});

  @override
  State<StatefulWidget> createState() {
    return FormPessoaState();
  }
}

class FormPessoaState extends State<FormPessoa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorCampoNome = TextEditingController();
  final TextEditingController _controladorCampoTelefone =
      TextEditingController();
  final TextEditingController _controladorCampoCpf = TextEditingController();
  int _id = null;

  @override
  void initState() {
    super.initState();
    if (widget.pessoa != null) {
      _id = widget.pessoa.id;
      _controladorCampoNome.text = widget.pessoa.nome;
      _controladorCampoTelefone.text = widget.pessoa.telefone;
      _controladorCampoCpf.text = widget.pessoa.cpf;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Pessoas'),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Editor(_controladorCampoNome, 'Pessoa', 'Informe a pessoa',
                  Icons.assessment_sharp, true),
              Editor(_controladorCampoTelefone, 'Observação',
                  'Informe o telefone', Icons.notes, false),
              Editor(_controladorCampoCpf, 'Observação', 'Informe o CPF',
                  Icons.notes, false),
              RaisedButton(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Confirmar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() => _savePessoa(context));
                    }
                  }),
              SizedBox(height: 16),
              RaisedButton(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Excluir',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                  })
            ],
          ),
        )));
  }

  void _savePessoa(context) {
    PessoasDao _dao = new PessoasDao();
    if (_id != null) {
      final pessoaAlterada = Pessoa(_id, _controladorCampoNome.text,
          _controladorCampoTelefone.text, _controladorCampoCpf.text);
      _dao.update(pessoaAlterada).then((id) => Navigator.pop(context));
    } else {
      final pessoaCriada = Pessoa(0, _controladorCampoNome.text,
          _controladorCampoTelefone.text, _controladorCampoCpf.text);
      _dao.save(pessoaCriada).then((id) => Navigator.pop(context));
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.pop(context);
        setState(() => _excluir(context));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exclusão de Pessoas"),
      content: Text("Você deseja excluir esta pessoa?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _excluir(BuildContext context) {
    PessoasDao _dao = new PessoasDao();
    _dao.delete(_id).then((id) => Navigator.pop(context));
  }
}
