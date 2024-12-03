class UserAddress {
  String streetAdress;
  String city;
  String postCode;

  UserAddress(
      {required this.streetAdress, required this.city, required this.postCode});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'streetAddress': streetAdress,
      'city': city,
      'postCode': postCode
    };
  }

  factory UserAddress.fromJson(Map<String, dynamic> map) => UserAddress(
      streetAdress: map['streetAddress'],
      city: map['city'],
      postCode: map['postCode']);
}
