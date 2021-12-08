import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/core/repository/profile_repository.dart';
import 'package:sms/screens/profile_screen/bloc/profile_event.dart';
import 'package:sms/screens/profile_screen/bloc/profile_state.dart';

class  ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileRepository profileRepository) :
        _profileRepository = profileRepository,
    super(const ProfileStateInit()){
    on<FetchProfile>(_onFetchProfile);
  }
  final ProfileRepository _profileRepository;

  void _onFetchProfile(
      FetchProfile event,
      Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try{
      var profile = await _profileRepository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (error) {
      emit(ProfileFailed(error.toString()));
      print('$error');
    }
  }
}
