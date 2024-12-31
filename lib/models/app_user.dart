import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sklens_user_app/models/user_address.dart';

class AppUser {
  String uid;
  String email;
  UserAddress? userAddress;
  String? userName;
  String? phone;
  Timestamp? userCreationTime;

  AppUser(
      {required this.uid,
      required this.email,
      this.userAddress,
      this.userName,
      this.phone,
      this.userCreationTime});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'userAddress': userAddress?.toJson(),
      'userName': userName,
      'phone': phone,
      'userCreationTime': userCreationTime
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> map) => AppUser(
        uid: map['uid'],
        email: map['email'],
        userAddress: UserAddress.fromJson(map['userAddress']),
        userName: map['userName'],
        phone: map['phone'],
        userCreationTime: map['userCreationTime'],
      );
}
