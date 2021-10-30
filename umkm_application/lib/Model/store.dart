class Store {
  String id;
  String? address;
  String? bukalapakName;
  String city;
  String? description;
  String? email;
  String? facebookAcc;
  String image;
  String? instagramAcc;
  String? phoneNumber;
  String province;
  String? shopeeName;
  List<String> tags;
  String? tokopediaName;
  String name;
  String? youtubeLink;

  Store(
      {required this.id,
      required this.name,
      required this.image,
      required this.city,
      required this.province,
      required this.tags,
      this.bukalapakName,
      this.address,
      this.description,
      this.email,
      this.facebookAcc,
      this.instagramAcc,
      this.phoneNumber,
      this.shopeeName,
      this.tokopediaName,
      this.youtubeLink});
}
