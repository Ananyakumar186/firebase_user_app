class UserAddress {
  String streetAdress;
  String city;
  String postCode;
  String state;
  String country;

  UserAddress({
    required this.streetAdress,
    required this.city,
    required this.postCode,
    required this.country,
    required this.state
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'streetAddress': streetAdress,
      'city': city,
      'postCode': postCode,
      'state': state,
      'country':country
    };
  }

  factory UserAddress.fromJson(Map<String, dynamic> map) => UserAddress(
      streetAdress: map['streetAddress'],
      city: map['city'],
      postCode: map['postCode'],
      state: map['state'],
      country: map['country']
  );

}
