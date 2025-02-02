import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_teste/data/repositories/auth/auth_repository.dart';
import 'package:flutter_teste/domain/entities/user_entity.dart';

class MainViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  User _user = NotLoggedUser();

  User get user => _user;

  late final StreamSubscription _userSubscription;

  MainViewModel(this._authRepository) {
    _userSubscription = _authRepository.userObserver().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
