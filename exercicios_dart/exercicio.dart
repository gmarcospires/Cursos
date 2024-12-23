main() {
  print('Olá Dart!');
  int a = 2;
  double b = 3.1314;
  var c = 'Olá Dart!';
  bool d = true;
  bool e = c is String;
  var nomes = ['Ana', 'Bia', 'Carlos']; // Lista [array]
  // var List<String> listNomes = ['Ana', 'Bia', 'Carlos']; // INCORRETO (var)
  nomes.add('Daniel');
  print(nomes.length);
  print(nomes.elementAt(0));
  print(nomes[0]);
  print(nomes);

  Set<int> conjunto = {0, 1, 2, 3, 4, 4, 4, 4, 4, 4}; // Set
  print(conjunto.length);
  print(conjunto is Set);

  Map<String, double> notasDosAlunos = {
    'Ana': 9.7,
    'Bia': 9.2,
    'Carlos': 7.8,
  }; // Map [JSON]

  print(notasDosAlunos.length);
  print(notasDosAlunos['Ana']);

  for (var chave in notasDosAlunos.keys) {
    print('Chave = $chave');
  }

  for (double valor in notasDosAlunos.values) {
    print('Valor = $valor');
  }

  for (var registro in notasDosAlunos.entries) {
    print('${registro.key} = ${registro.value}');
  }

  dynamic x = 'Um texto bem legal';
  print(x);
  x = 123;
  print(x);
  x = false;
  print(x);

  var y = 123;
  final z = 123; // valor constante
  // z= 456; // Erro
  const w = 123; //
  // w = 456; // Erro

  // const deve ser inicializada com valor. Mesmo em um objeto, será sempre constante
  // final pode ser inicializada em tempo de execução. Num objeto, a referência será constante, mas os valores podem ser mudados
  // Mas ambas serão constantes

  final List<String> names = ["Ricarth", "Lima"];
  const List<String> constNames = ["Ricarth", "Lima"];

  names[0] = "Kako"; // Funciona!
  // constNames[0] = "Kako"; // Erro em tempo de execução!
}
