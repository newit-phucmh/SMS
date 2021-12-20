import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sms/core/utils/constant.dart';
import 'package:sms/core/widgets/default_button.dart';
import 'package:sms/core/widgets/no_account_text.dart';
import 'package:sms/core/widgets/socal_card.dart';
import 'package:sms/screens/login/bloc/login_bloc.dart';

import '../../../size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  bool? remember = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.of(context).size.height * 0.1,
                  scale: 1.0,//40%
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Sign in with your email and password',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      shape: const CircleBorder(),
                      activeColor: Constants.kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                    const Text('Remember me'),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: () {},
                    ),
                    SocalCard(
                      icon: 'assets/icons/facebook-2.svg',
                      press: () {},
                    ),
                    SocalCard(
                      icon: 'assets/icons/twitter.svg',
                      press: () {},
                    ),
                  ],
                ),
                const NoAccountText(),
              ],
            ),
          ),
        )

      )
    );
  }

}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            errorText: state.username.invalid ? 'invalid email' : null,

          ),

        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'password',
              hintText: 'Enter password',
              errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : DefaultButton(
          text: 'Login',
          press: state.status.isValidated
              ? () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          }
              : null,
        );
      },
    );
  }
}
