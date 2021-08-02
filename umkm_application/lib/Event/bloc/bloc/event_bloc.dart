import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:umkm_application/data/repositories/event_repositories.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial());

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is addEventButtonPressed) {
      yield EventLoading();
      try {
        var imageLink = await EventRepository.uploadImage(event.imageFile);
        if (imageLink != null) {
          await EventRepository.addEvent(
              event.name,
              event.location,
              event.description,
              event.author,
              event.link,
              event.contactPerson,
              event.date,
              imageLink);
          yield EventSucceed();
        } else {
          yield EventFailed(message: "Failed to upload image banner");
        }
      } catch (e) {
        yield EventFailed(message: e.toString());
      }
    }
  }
}
