import 'brand_model.dart';
import 'image_model.dart';

class Telescope {
  String? id;
  String model;
  Brand brand;
  String type;
  String dimension;
  num weightInpound;
  String focusType;
  num lensDiameterInMM;
  num price;
  num stock;
  num avgRating = 0;
  num discount = 0;
  ImageModel thumbnail;
  String name;
  List<ImageModel> additionalImage;
  String? description;

  Telescope(
      {this.id,
      required this.model,
      required this.brand,
      required this.type,
      required this.dimension,
      required this.weightInpound,
      required this.focusType,
      required this.lensDiameterInMM,
      required this.price,
      required this.stock,
      required this.avgRating,
      required this.discount,
      required this.thumbnail,
      required this.name,
      required this.additionalImage,
      this.description});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'model': model,
      'brand': brand,
      'type': type,
      'dimension': dimension,
      'weightInPound': weightInpound,
      'focuType': focusType,
      'lensDiameterInMM': lensDiameterInMM,
      'price': price,
      'stock': stock,
      'avgRating': avgRating,
      'discount': discount,
      'thumbnail': thumbnail,
      'additionalImage': additionalImage,
      'description': description
    };
  }

  factory Telescope.fromJson(Map<String, dynamic> map) => Telescope(
        id: map[brandFieldId],
        name: map[brandFieldName],
        model: map['model'],
        brand: map['brand'],
        type: map['type'],
        dimension: map['dimension'],
        weightInpound: map['weightInPound'],
        focusType: map['focusType'],
        lensDiameterInMM: map['lensDiameterInMM'],
        price: map['price'],
        stock: map['stock'],
        avgRating: map['avgRating'],
        discount: map['discount'],
        thumbnail: map['thumbnail'],
        additionalImage: map['additionalImage'],
        description: map['description'],
      );
}
