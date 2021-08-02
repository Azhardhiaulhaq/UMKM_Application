part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class addEventButtonPressed extends EventEvent {
  String name, location, description, author, contactPerson, link;
  DateTime date;
  File imageFile;
  addEventButtonPressed(
      {
      required this.name,
      required this.location,
      required this.description,
      required this.author,
      required this.contactPerson,
      required this.link,
      required this.date,
      required this.imageFile});
}
