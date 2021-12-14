import 'package:equatable/equatable.dart';

abstract class QREvent extends Equatable {
  const QREvent();
  @override
  List<Object> get props => [];
}

class CheckIn extends QREvent{
   CheckIn(this.courseId);
   String courseId;
}
