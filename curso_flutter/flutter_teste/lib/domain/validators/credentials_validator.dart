import 'package:flutter_teste/domain/dtos/credentials.dart';
import 'package:lucid_validation/lucid_validation.dart';

class CredentialsValidator extends LucidValidator<Credentials> {
  CredentialsValidator() {
    ruleFor((c) => c.email, key: 'email')
        .notEmpty(message: 'E-mail não pode ser vazio.')
        .validEmail(message: 'E-mail inválido.');

    ruleFor((c) => c.password, key: 'password')
        .notEmpty(message: 'Senha não pode ser vazia.')
        .minLength(6, message: 'Senha deve ter no mínimo 6 caracteres.')
        .mustHaveLowercase(
            message: 'Senha deve ter no mínimo uma letra minúscula.')
        .mustHaveUppercase(
            message: 'Senha deve ter no mínimo uma letra maiúscula.')
        .mustHaveNumber(message: 'Senha deve ter no mínimo um número.')
        .mustHaveSpecialCharacter(
            message: 'Senha deve ter no mínimo um caracter especial.');
  }
}
