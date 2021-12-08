import 'package:equatable/equatable.dart';
import 'package:sms/core/models/studdent_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileStateInit extends ProfileState {
  const ProfileStateInit();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.studentProfileModel);
  final UserInfoModel studentProfileModel;
  @override
  List<Object> get props => [studentProfileModel];
}

class ProfileFailed extends ProfileState {
  ProfileFailed(this.message);
  final String message;
  @override
  List<Object> get props => [message];

}

