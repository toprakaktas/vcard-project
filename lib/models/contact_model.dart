class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String address;
  String company;
  String profession;
  String website;
  String image;
  bool favorite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.email = '',
    this.address = '',
    this.company = '',
    this.profession = '',
    this.website = '',
    this.image = '',
    this.favorite = false,
  });
}
