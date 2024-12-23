import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import './questao.dart';
import './resposta.dart';

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
  void _response(int index) {
    setState(() {
      _perguntaSelecionada++;
    });
    print('Resposta $index foi selecionada!');
    print(_perguntaSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> perguntas = [
      'Qual é a sua cor favorita?',
      'Qual é o seu animal favorito?',
    ];
    return ShadApp(
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(
          // background: Colors.blue,
          primary: Color.fromARGB(255, 239, 60, 70),
          secondary: Color.fromARGB(255, 0, 133, 255),
        ),
      ),
      theme: ShadThemeData(
          colorScheme: const ShadSlateColorScheme.light(
            // background: Colors.blue,
            primary: Color.fromARGB(255, 239, 60, 70),
            secondary: Color.fromARGB(255, 0, 133, 255),
          ),
          brightness: Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: <Widget>[
            Questao(perguntas.elementAt(_perguntaSelecionada)),
            Text(
              perguntas.elementAt(_perguntaSelecionada),
              style: ShadTheme.of(context).textTheme.bodyMedium,
            ),
            Resposta('Resposta 1', () => _response(1)),
            Resposta('Resposta 2', () => _response(2)),
            Resposta('Resposta 3', () => _response(3)),
            ElevatedButton(
              onPressed: null,
              child: const Text('Resposta Desabilitada'),
            ),
            ShadButton(
              onPressed: null,
              child: const Text('Shad Button'),
            )
          ],
        ),
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
