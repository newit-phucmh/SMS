import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/authentication/authentication.dart';
import 'package:sms/screens/login/bloc/login_bloc.dart';
import 'package:sms/screens/profile_screen/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External


  // Bloc
  sl.registerFactory(
        () => ProfileBloc(sl())
  );

  sl.registerFactory(
          () => LoginBloc(sl())
  );

  sl.registerFactory(
          () => AuthenticationBloc(sl())
  );

}
