import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final String pergunta;
  final List<Map<String, Object>> respostas;
  final void Function(int, int) response;

  const Questionario({
    super.key,
    required this.pergunta,
    required this.respostas,
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Questao(pergunta),
        ...(respostas.asMap().entries).map((entry) {
          int index = entry.key;
          var resposta = entry.value;
          return Resposta(resposta['texto'].toString(),
              () => response(index, resposta['pontuacao'] as int));
        }),
      ],
    );
  }
}
