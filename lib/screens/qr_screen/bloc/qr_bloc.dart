import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/core/repository/check_in_repository.dart';
import 'package:sms/screens/qr_screen/bloc/qr_event.dart';
import 'package:sms/screens/qr_screen/bloc/qr_state.dart';

class  QRScreenBloc extends Bloc<QREvent, QRState> {
  QRScreenBloc(CheckInRepository checkInRepository) :
        _checkInRepository = checkInRepository,
    super(const QRStateInit()){
    on<CheckIn>(_onCheckIn);
  }
  final CheckInRepository _checkInRepository;

  void _onCheckIn(
      CheckIn event,
      Emitter<QRState> emit) async {
    emit(const QRLoading());
    try{
      var result = await _checkInRepository.checkIn(event.courseId);
      emit(QRCheckedIn(result));
    } catch (error) {
      emit(QRCheckInFailed(error.toString()));
      print('$error');
    }
  }
}
