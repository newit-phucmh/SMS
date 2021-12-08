import 'package:equatable/equatable.dart';
import 'package:sms/core/repository/profile_repository.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent{
  const FetchProfile();
}
