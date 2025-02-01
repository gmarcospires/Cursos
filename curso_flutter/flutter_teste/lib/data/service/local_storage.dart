import 'package:flutter_teste/data/exceptions/exceptions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  AsyncResult<String> saveData(String key, String value) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.setString(key, value);
      return Success(value);
    } catch (e, stackTrace) {
      return Failure(LocalStorageException(e.toString(), stackTrace));
    }
  }

  AsyncResult<String> getData(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final value = shared.getString(key);
      return value != null
          ? Success(value)
          : Failure(LocalStorageException('Data not found', null));
    } catch (e, stackTrace) {
      return Failure(LocalStorageException(e.toString(), stackTrace));
    }
  }

  AsyncResult<bool> removeData(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final isRemoved = await shared.remove(key);
      return isRemoved
          ? Success(isRemoved)
          : Failure(LocalStorageException('Data not removed', null));
    } catch (e, stackTrace) {
      return Failure(LocalStorageException(e.toString(), stackTrace));
    }
  }
}
