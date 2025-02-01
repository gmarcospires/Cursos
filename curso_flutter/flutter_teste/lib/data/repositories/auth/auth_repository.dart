import 'package:flutter_teste/domain/dtos/credentials.dart';
import 'package:flutter_teste/domain/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AuthRepository {
  AsyncResult<LoggedUser> login(Credentials credentials);
  AsyncResult<Unit> logout();
  AsyncResult<LoggedUser> getUser();
  // regiser();
  Stream<User> userObserver(); //reativo

  void dispose();
}
