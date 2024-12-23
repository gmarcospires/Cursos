import './pessoa2.dart';

main() {
  var p1 = Pessoa('João', '123.456.789-00');
  print("O nome da pessoa é ${p1.nome} e o CPF é ${p1._cpf}");

  var p2 = Pessoa2('João', '123.456.789-00');
  // print("O nome da pessoa é ${p2.nome} e o CPF é ${p2._cpf}"); // Erro, cpf é privado
  print("O nome da pessoa é ${p2.nome} e o CPF é ???");

  print("O nome da pessoa é ${p2.nome} e o CPF é ${p2.cpf}");

  p2.cpf = '987.654.321-00';
  print("O nome da pessoa é ${p2.nome} e o CPF é ${p2.cpf}");
}

class Pessoa {
  String nome;
  String _cpf;

  Pessoa(this.nome, this._cpf);
}
