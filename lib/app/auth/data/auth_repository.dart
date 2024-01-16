import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../config/local_storage.dart';
import '../../login/dto/login_input.dart';
import '../../signup/dto/sign_up.input.dart';
import '../../user/entity/user.entity.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  firstTime,
  error,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  final FlutterSecureStorage storage = LocalStorage().storage;

  AuthenticationRepository();

  Stream<AuthenticationStatus> get status async* {
    bool token = await hasToken();
    bool firstTime = await isFirstTime();
    if (firstTime) {
      yield AuthenticationStatus.firstTime;
    } else if (token) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  void dispose() => _controller.close();

  Future<void> logIn(LoginInput loginInput) async {
    // await persistToken(tokens['accessToken'], tokens['refreshToken']);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> signUp(SignUpInput signUpInput) async {
    // await persistToken(tokens['accessToken'], tokens['refreshToken']);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<UserEntity?> getUser() async {
    return UserEntity.fromJson({});
  }

  Future<void> persistToken(String accessToken, String refreshToken) async {
    await storage.write(key: "accessToken", value: accessToken);
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  Future<bool> hasToken() async {
    var accessToken = await storage.read(key: "accessToken");
    if (accessToken == null) return false;
    return true;
  }

  Future<bool> isFirstTime() async {
    var firstTime = await storage.read(key: "firstTime");
    if (firstTime == null) return true;
    return false;
  }

  Future<void> setFirstTime() async {
    await storage.write(key: "firstTime", value: jsonEncode({"firstTime": false}));
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void logOut() async {
    _controller.add(AuthenticationStatus.unauthenticated);
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
  }
}
