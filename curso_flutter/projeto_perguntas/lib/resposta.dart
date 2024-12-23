import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() _response;
  const Resposta(this.texto, this._response, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      width: double.infinity,
      onPressed: () => _response(),
      child: Text(texto),
    );
  }
}
