import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umkm_application/Event/bloc/bloc/event_bloc.dart';
import 'package:umkm_application/Event/ui/event_form_page.dart';

class EventFormScreen extends StatelessWidget {
  const EventFormScreen({
    Key? key,
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
            author: '',
            contactPerson: '',
            date: DateTime.now(),
            description: '',
            eventID: '',
            link: '',
            linkImage: '',
            location: '',
            name: '',
          )),
    );
  }
}
