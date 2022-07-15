part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();
  
  @override
  List<Object> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}
// ignore: must_be_immutable
class AnnouncementSucceed extends AnnouncementState {
  
}

// ignore: must_be_immutable
class AnnouncementFailed extends AnnouncementState {
  String message;
  AnnouncementFailed({required this.message});
}
