import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String email;

  @HiveField(3)
  String fullName;

  @HiveField(4)
  String address;

  @HiveField(5)
  String hobbies;

  @HiveField(6)
  String impression;

  @HiveField(7)
  String phoneNumber;

  @HiveField(8)
  bool isSubscribed;

  @HiveField(9)
  String? subscriptionUntil;

  @HiveField(10)
  int remainingQuota;

  User({
    required this.username,
    required this.password,
    this.email = '',
    this.fullName = 'No Name',
    this.address = 'No Address',
    this.hobbies = 'No Hobbies',
    this.impression = 'No Impression',
    this.phoneNumber = 'No Phone Number',
    this.isSubscribed = false,
    this.subscriptionUntil,
    this.remainingQuota = 0,
  });
}
