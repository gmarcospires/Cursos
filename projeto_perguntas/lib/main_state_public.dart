import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

main() {
  runApp(const PerguntaApp());
}

class ShadTheme {
  static ThemeData of(BuildContext context) {
    return Theme.of(context);
  }
}

class PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0; // NÃO é um estado
  void response(int index) {
    setState(() {
      perguntaSelecionada++;
    });
    print('Resposta $index foi selecionada!');
    print(perguntaSelecionada);
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
            Text(perguntas.elementAt(perguntaSelecionada)),
            Text(
              perguntas.elementAt(perguntaSelecionada),
              style: ShadTheme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: () => response(1),
              child: const Text('Resposta 1'),
            ),
            ElevatedButton(
              onPressed: () => response(2),
              child: const Text('Resposta 2'),
            ),
            ElevatedButton(
              onPressed: () => response(3),
              child: const Text('Resposta 3'),
            ),
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
    return PerguntaAppState();
  }
}
