import 'dart:async';

import 'package:flutter_teste/data/repositories/auth/auth_repository.dart';
import 'package:flutter_teste/data/service/auth/auth_client_http.dart';
import 'package:flutter_teste/data/service/auth/auth_local_storage.dart';
import 'package:flutter_teste/domain/dtos/credentials.dart';
import 'package:flutter_teste/domain/entities/user_entity.dart';
import 'package:flutter_teste/domain/validators/credentials_validator.dart';
import 'package:flutter_teste/utils/validation/lucid_validator_extension.dart';
import 'package:result_dart/result_dart.dart';

class RemoteAuthRepository implements AuthRepository {
  final AuthLocalStorage _authLocalStorage;
  final AuthClientHttp _authClientHttp;

  final StreamController<User> _streamController =
      StreamController<User>.broadcast();

  RemoteAuthRepository(this._authLocalStorage, this._authClientHttp);

  @override
  AsyncResult<LoggedUser> getUser() {
    return _authLocalStorage.getUser();
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) {
    final validator = CredentialsValidator();

    return validator
        .validateResult(credentials)
        .flatMap(_authClientHttp.login)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(
          (user) => _streamController.add(user),
        );

// if (!validator.validate(credentials).isValid) {
    //   return Failure(Exception('Invalid credentials'));
    // }

    // return _authClientHttp
    //     .login(credentials)
    //     .flatMap(_authLocalStorage.saveUser)
    //     .onSuccess(
    //       (user) => _streamController.add(user),
    //     );
  }

  @override
  AsyncResult<Unit> logout() {
    return _authLocalStorage.removeUser().pure(unit).onSuccess(
          (_) => _streamController.add(const NotLoggedUser()),
        );
  }

  @override
  Stream<User> userObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
