class CartModel {
  String telescopeId;
  String telescopeModel;
  num price;
  String imageUrl;
  num quantity;

  CartModel({
    required this.telescopeId,
    required this.telescopeModel,
    required this.price,
    required this.imageUrl,
    required this.quantity
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'telescopeId': telescopeId,
      'telescopeModel': telescopeModel,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> map) =>
      CartModel(
          telescopeId: map['telescopeId'],
          telescopeModel: map['telescopeModel'],
          price: map['price'],
          imageUrl: map['imageUrl'],
          quantity: map['quantity'] ?? 0,
      );
}
