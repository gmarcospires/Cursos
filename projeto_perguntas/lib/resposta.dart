import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() _response;
  const Resposta(this.texto, this._response, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _response(),
          child: Text(texto),
        ));
  }
}
