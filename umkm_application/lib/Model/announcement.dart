class Announcement {
  String id;
  String? content;
  DateTime createdAt;
  DateTime deadlines;
  List<String> documents;
  String? email;
  String? phoneNumber;
  String title;
  String author;

  Announcement(
      {required this.id,
      this.content,
      required this.createdAt,
      required this.deadlines,
      required this.documents,
      this.email,
      this.phoneNumber,
      required this.title,
      required this.author
      });
}
