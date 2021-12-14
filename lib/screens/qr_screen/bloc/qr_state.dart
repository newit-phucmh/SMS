import 'package:equatable/equatable.dart';
import 'package:sms/core/models/studdent_profile_model.dart';

abstract class QRState extends Equatable {
  const QRState();
  @override
  List<Object> get props => [];
}

class QRStateInit extends QRState {
  const QRStateInit();
}

class QRLoading extends QRState {
  const QRLoading();
}

class QRCheckedIn extends QRState {
  QRCheckedIn(this.mess);
  final String mess;
  @override
  List<Object> get props => [mess];
}

class QRCheckInFailed extends QRState {
  QRCheckInFailed(this.message);
  final String message;
  @override
  List<Object> get props => [message];

}

