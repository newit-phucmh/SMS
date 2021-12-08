
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/core/repository/authentication_repository.dart';
import 'package:sms/screens/login/bloc/login_bloc.dart';
import 'package:sms/screens/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
