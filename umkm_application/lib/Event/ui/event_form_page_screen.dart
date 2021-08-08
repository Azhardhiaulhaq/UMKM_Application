import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Event/bloc/bloc/event_bloc.dart';
import 'package:umkm_application/Event/ui/event_form_page.dart';

class EventFormScreen extends StatelessWidget {
    final String eventID;
  final String name;
  final String location;
  final String description;
  final String author;
  final String link;
  final String contactPerson;
  final String linkImage;
  final DateTime date;
  const EventFormScreen({
    Key? key, required this.eventID,required this.name, required this.location,required this.description,required this.author,
    required this.contactPerson, required this.linkImage, required this.date, required this.link, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<EventBloc>(
          create: (context) => EventBloc(),
          child: EventFormPage(
            title: 'Event Form',
            author: author,
            contactPerson: contactPerson,
            date: date,
            description: description,
            eventID: eventID,
            link: link,
            linkImage: linkImage,
            location: location,
            name: name,
          )),
    );
  }
}
