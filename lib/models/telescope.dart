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
      required this.additionalImage,
      this.description});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'brand': brand.toJson(),
      'type': type,
      'dimension': dimension,
      'weightInPound': weightInpound,
      'focuType': focusType,
      'lensDiameterInMM': lensDiameterInMM,
      'price': price,
      'stock': stock,
      'avgRating': avgRating,
      'discount': discount,
      'thumbnail': thumbnail.toJson(),
      'additionalImage': additionalImage.map((image) => image.toJson()).toList(),
      'description': description
    };
  }

  factory Telescope.fromJson(Map<String, dynamic> map) => Telescope(
        id: map['id'],
        model: map['model'],
        brand: Brand.fromJson(map['brand']),
        type: map['type'],
        dimension: map['dimension'],
        weightInpound: map['weightInPound'],
        focusType: map['focusType'],
        lensDiameterInMM: map['lensDiameterInMM'],
        price: map['price'],
        stock: map['stock'],
        avgRating: map['avgRating'],
        discount: map['discount'],
        thumbnail: ImageModel.fromJson(map['thumbnail']),
        additionalImage: (map['additionalImage'] as List)
            .map((image) => ImageModel.fromJson(image))
            .toList(),
        description: map['description'],
      );
}
