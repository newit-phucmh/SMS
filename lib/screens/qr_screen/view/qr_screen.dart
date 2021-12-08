
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sms/authentication/bloc/authentication_bloc.dart';
import 'package:sms/core/models/bottom_stateful_screen.dart';

class QRScreen extends BottomStatelessScreen{
  @override
  // TODO: implement bottomBarIcon
  Icon get bottomBarIcon => const Icon(Icons.home);

  @override
  // TODO: implement bottomBarTitle
  String get bottomBarTitle => 'Home';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return QRScreenWidget();
  }

}

class QRScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScreenWidgetState();
}

class _QRScreenWidgetState extends State<QRScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  context.read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
                child:const Text('Logout'))
          ],
        ),
      ),
    );
  }

}