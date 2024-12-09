class ImageModel {
  String? imageName;
  String? directoryName;
  String downloadUrl;

  ImageModel({
    this.imageName,
    this.directoryName,
    required this.downloadUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageName': imageName,
      'directoryName': directoryName,
      'downloadUrl': downloadUrl,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      imageName: map['imageName'] as String?,
      directoryName: map['directoryName'] as String?,
      downloadUrl: map['downloadUrl'] ?? '',
    );
  }
}
