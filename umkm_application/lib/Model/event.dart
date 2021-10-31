class Event {
  String id;
  String author;
  String image;
  String contactPerson;
  DateTime date;
  String description;
  String link;
  String name;
  String location;

  Event(
      {required this.id,
      required this.author,
      required this.image,
      required this.contactPerson,
      required this.date,
      required this.description,
      required this.link,
      required this.name,
      required this.location});

  static Event emptyEvent() {
    return Event(
        id: '',
        author: '',
        image: '',
        contactPerson: '',
        date: DateTime.now(),
        description: '',
        link: '',
        name: '',
        location: '');
  }
}
