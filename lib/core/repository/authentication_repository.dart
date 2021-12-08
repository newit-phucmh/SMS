import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/core/repository/login_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final loginRepository = LoginRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    var sharePr = await SharedPreferences.getInstance();
    if (sharePr.getString('token') == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.authenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    var responseModel = await loginRepository.login(username, password);
    var sharePr = await SharedPreferences.getInstance();
    if (responseModel.accessToken.isNotEmpty) {
      await sharePr.setString('token', responseModel.accessToken);
      await sharePr.setString('userId', responseModel.userId.toString());
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logOut() async {
    var sharePr = await SharedPreferences.getInstance();
    await loginRepository.logout(sharePr.getString('token').toString());
    print('get token from memory: ${sharePr.getString('token')}');
    _controller.add(AuthenticationStatus.unauthenticated);
    await sharePr.remove('token');
    await sharePr.remove('userId');
    print(
        'get token from memory: ${sharePr.getString('token')}');
  }

  void dispose() => _controller.close();
}
