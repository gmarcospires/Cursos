class Pessoa2 {
  String nome;
  String _cpf;

  Pessoa2(this.nome, this._cpf);

  String get cpf {
    return _cpf;
  }

  set cpf(String cpf) {
    _cpf = cpf;
  }
}
