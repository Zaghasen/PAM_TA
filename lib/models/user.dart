class User {
  String username;
  String password;
  String email;
  String fullName;
  String address;
  String hobbies;
  String impression;
  String phoneNumber;

  User({
    required this.username,
    required this.password,
    this.email = '',
    this.fullName = 'No Name',
    this.address = 'No Address',
    this.hobbies = 'No Hobbies',
    this.impression = 'No Impression',
    this.phoneNumber = 'No Phone Number',
  });
}
