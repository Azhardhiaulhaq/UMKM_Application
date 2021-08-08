part of 'event_bloc.dart';


abstract class EventState extends Equatable {
  const EventState();
  
  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}
class EventLoading extends EventState {}
// ignore: must_be_immutable
class EventSucceed extends EventState {
  
}
class DeleteEventSucceed extends EventState {
  
}

// ignore: must_be_immutable
class EventFailed extends EventState {
  String message;
  EventFailed({required this.message});
}

class DeleteEventFailed extends EventState {
  String message;
  DeleteEventFailed({required this.message});
}