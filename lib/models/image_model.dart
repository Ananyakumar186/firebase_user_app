class ImageModel {
  String? imageName;
  String? directoryName;
  String? downloadUrl;

  ImageModel(
      {required String imageName,
      required String directoryName,
      required String downloadUrl});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageName': imageName,
      'directoryName': directoryName,
      'downloadUrl': downloadUrl
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> map) => ImageModel(
      imageName: map['imageName'],
      directoryName: map['directoryName'],
      downloadUrl: map['downloadUrl']);
}
