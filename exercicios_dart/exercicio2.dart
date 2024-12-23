main() {
  soma(2, 3.1);
  soma(2, 3);
  soma('Olá', ' Dart!');

  print('O valor da soma é ${somaInt(2, 3)}');
  // print(somaInt(2, 3.1)); // erro

  final r = somaInt(2, 3);
  print('O valor da soma é $r');

  somaVoid(2, 3);

  execSoma(somaInt);
  // execSoma(soma); // Erro

  print(exec2(2, 3, (x, y) => x * y));

  var p1 = Produto('Caneta', 4.99);
  print("O produto ${p1.nome} tem preço R\$${p1.preco}");

  var p2 = new Produto2();
  p2.nome = 'Lápis';
  p2.preco = 2.99;
  print("O produto ${p2.nome} tem preço R\$${p2.preco}");

  var p3 = ProdutoNomeado(nome: 'Borracha', preco: 1.99);
  print("O produto ${p3.nome} tem preço R\$${p3.preco}");

  var p4 = ProdutoNomeado(nome: 'Folha sulfite');
  print("O produto ${p4.nome} tem preço R\$${p4.preco}");

  imprimirProduto(p1);
  imprimirProduto2(nome: 'Caderno', preco: 9.99);

  imprimirLoop(3, nome: 'Caneta', preco: 4.99);
  /*
  Bloco de codigo comentado
  */
}

soma(a, b) // Os atributos serão dynamic
{
  print(a + b);
}

int somaInt(int a, int b) {
  return a + b;
}

void somaVoid(int a, int b) {
  print(a + b);
}

void execSoma(int Function(int, int) fn) {
  print(fn(2, 3));
}

int exec2(int a, int b, int Function(int, int) fn) {
  return fn(a, b);
}

class Produto {
  String nome;
  double preco;

  Produto(this.nome, this.preco); // Construtor
  // Produto(String nome, double preco) {
  //   this.nome = nome;
  //   this.preco = preco;
  // }
}

class Produto2 {
  String? nome;
  double? preco;
}

class ProdutoNomeado {
  String? nome;
  double? preco;

  ProdutoNomeado({this.nome, this.preco = 9.99}); // Construtor nomeado
}

imprimirProduto(Produto p) {
  print("O produto ${p.nome} tem preço R\$${p.preco}");
}

imprimirProduto2({String? nome, double? preco}) {
  print("O produto ${nome} tem preço R\$${preco}");
}

imprimirLoop(int vezes, {String? nome, double? preco}) {
  for (var i = 0; i < vezes; i++) {
    print("O produto ${nome} tem preço R\$${preco}");
  }
}
