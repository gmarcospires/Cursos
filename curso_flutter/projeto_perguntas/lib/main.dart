import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

main() {
  runApp(const PerguntaApp());
}

class ShadTheme {
  static ThemeData of(BuildContext context) {
    return Theme.of(context);
  }
}

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final List<Map<String, Object>> perguntas = const [
    {
      'pergunta': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 5},
        {'texto': 'Verde', 'pontuacao': 3},
        {'texto': 'Branco', 'pontuacao': 1},
      ],
    },
    {
      'pergunta': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Coelho', 'pontuacao': 10},
        {'texto': 'Cobra', 'pontuacao': 5},
        {'texto': 'Elefante', 'pontuacao': 3},
        {'texto': 'Leão', 'pontuacao': 1},
      ],
    },
    {
      'pergunta': 'Qual é o seu instrutor favorito?',
      'respostas': [
        {'texto': 'Maria', 'pontuacao': 10},
        {'texto': 'João', 'pontuacao': 5},
        {'texto': 'Leo', 'pontuacao': 3},
        {'texto': 'Pedro', 'pontuacao': 1},
      ],
    },
  ];

  void _response(int index, int pontuacao) {
    setState(() {
      _perguntaSelecionada++;
      _pontuacaoTotal += pontuacao;
    });
    print('Resposta $index foi selecionada!');
    print('Pontuação: $pontuacao');
  }

  bool get hasSelectedQuestion {
    return _perguntaSelecionada < perguntas.length;
  }

  void _restart() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: hasSelectedQuestion
            ? Questionario(
                pergunta:
                    perguntas[_perguntaSelecionada]['pergunta'].toString(),
                respostas: perguntas[_perguntaSelecionada]['respostas']
                    as List<Map<String, Object>>,
                response: _response,
              )
            : Resultado(_pontuacaoTotal, _restart),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  State<PerguntaApp> createState() {
    return _PerguntaAppState();
  }
}
