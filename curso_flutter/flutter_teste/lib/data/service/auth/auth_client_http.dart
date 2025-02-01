import 'package:flutter_teste/data/service/client_http.dart';
import 'package:flutter_teste/domain/dtos/credentials.dart';
import 'package:flutter_teste/domain/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

class AuthClientHttp {
  final ClientHttp _clientHttp;

  AuthClientHttp(this._clientHttp);

  AsyncResult<LoggedUser> login(Credentials credentials) async {
    // final response = await _clientHttp.post('/login',
    //     {'email': credentials.email, 'password': credentials.password});

    // return response.map((json) => LoggedUser.fromJson(json.data));

    await Future.delayed(const Duration(seconds: 4));
    return Success(
      LoggedUser(
          email: 'teste@teste',
          id: 1,
          name: 'Teste',
          refreshToken: 'sajbsa',
          token: 'asjbsa'),
    );
  }
}
