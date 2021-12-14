import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:sms/authentication/bloc/authentication_bloc.dart';
import 'package:sms/core/models/bottom_stateful_screen.dart';
import 'package:sms/core/repository/profile_repository.dart';
import 'package:sms/core/widgets/bottom_loader_widget.dart';
import 'package:sms/screens/profile_screen/bloc/profile_bloc.dart';
import 'package:sms/screens/profile_screen/bloc/profile_event.dart';
import 'package:sms/screens/profile_screen/bloc/profile_state.dart';
import 'package:sms/screens/profile_screen/widgets/profile_avt.dart';
import 'package:sms/screens/profile_screen/widgets/profile_menu.dart';

class ProfileScreen extends BottomStatelessScreen {
  @override
  Icon get bottomBarIcon => const Icon(Icons.school);

  @override
  String get bottomBarTitle => 'Profile';

  @override
  Widget build(BuildContext context) {
    var profileRepository = ProfileRepository();
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: BlocProvider(
          create: (context) => ProfileBloc(profileRepository),
          child: ProfileScreenWidget(),
        ));
  }
}

class ProfileScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(const FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          if (state.studentProfileModel.id == -1) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested());
          }
        }
        if (state is ProfileFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Get Profile Failure')),
            );
        }
      },
      child: Padding(padding: const EdgeInsets.all(10), child: ProfileView()),
    );
  }
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return BottomLoaderWidget(strokeWidth: 3);
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const ProfilePic(),
                  const SizedBox(height: 20),
                  ProfileMenu(
                    text: 'Tài Khoản Của Tôi',
                    icon: 'assets/icons/User Icon.svg',
                    press: () {
                    },
                  ),
                  ProfileMenu(
                    text: 'Thông Báo',
                    icon: 'assets/icons/Bell.svg',
                    press: () {},
                  ),
                  ProfileMenu(
                    text: 'Cài Đặt',
                    icon: 'assets/icons/Settings.svg',
                    press: () {},
                  ),
                  ProfileMenu(
                    text: 'Trung Tâm Trợ Giúp',
                    icon: 'assets/icons/Question mark.svg',
                    press: () {},
                  ),
                  ProfileMenu(
                    text: 'Đăng Xuất',
                    icon: 'assets/icons/Log out.svg',
                    press: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested());
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Text('failed');
          }
        });
  }
}
