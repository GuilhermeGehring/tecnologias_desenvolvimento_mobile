import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final bool obrigatorio;
  final IconData icone;

  Editor(
      this.controlador, this.rotulo, this.dica, this.icone, this.obrigatorio);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty && this.obrigatorio) {
            return 'Este campo é obrigatório';
          }
          return null;
        },
        controller: controlador,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
      ),
    );
  }
}
