import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter_teste/data/repositories/auth/auth_repository.dart';
import 'package:flutter_teste/data/repositories/auth/remote_auth_repository.dart';
import 'package:flutter_teste/data/service/auth/auth_client_http.dart';
import 'package:flutter_teste/data/service/auth/auth_local_storage.dart';
import 'package:flutter_teste/data/service/client_http.dart';
import 'package:flutter_teste/data/service/local_storage.dart';
import 'package:flutter_teste/ui/auth/viewmodels/login_viewmodel.dart';

final injector = AutoInjector();

setupDependencies() {
  // Colocar todas as classes que serão instanciadas em RemoteAuthRepository
  injector.addSingleton<AuthRepository>(RemoteAuthRepository.new);
  injector.addInstance(Dio());
  injector.addSingleton(ClientHttp.new);
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(AuthClientHttp.new);
  injector.addSingleton(AuthLocalStorage.new);
  injector.addSingleton(LoginViewmodel.new);
}
