import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacaoTotal;
  final void Function() restart;

  const Resultado(this.pontuacaoTotal, this.restart, {super.key});

  String get textoResultado {
    if (pontuacaoTotal < 8) {
      return 'Parabéns!';
    } else if (pontuacaoTotal < 12) {
      return 'Você é bom!';
    } else if (pontuacaoTotal < 16) {
      return 'Impressionante!';
    } else {
      return 'Nível Jedi!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            textoResultado,
            style: TextStyle(fontSize: 28),
          ),
        ),
        TextButton(
          onPressed: restart,
          child: const Text('Reiniciar?'),
        ),
      ],
    );
  }
}
