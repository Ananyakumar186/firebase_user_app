import 'app_user.dart';

class Rating {
  AppUser appUser;
  num rating;

  Rating({ required this.appUser, required this.rating});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'appUser': appUser.toJson(),
      'rating': rating,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> map) => Rating(
    appUser: AppUser.fromJson(map['appUser']),
    rating: map['rating'],
  );
}
