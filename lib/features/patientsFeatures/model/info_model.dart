import 'package:cloud_firestore/cloud_firestore.dart';

enum InfoType { infographic, video }



class Info {
  String infoId;
  String title;
  String description;
  String description2;
  String description3;
  String description4;
  final String mainImageUrl;
  final List<String> images; // List of images
  final String videoUrl; // For video type
  final InfoType infoType; // Using InfoType class

  Info({
    required this.infoId,
    required this.title,
    required this.description,
    required this.description2,
    required this.description3,
    required this.description4,
    required this.mainImageUrl,
    required List<String> images, // Accept the list of images as a parameter
    required this.videoUrl, // Required for video type, can be empty for infographic
    required this.infoType, // New field
  })  : images = infoType == InfoType.video ? [] : images { // Ensure images are empty for video type
    if (infoType == InfoType.video && images.isNotEmpty) {
      throw ArgumentError('Images must be empty for video type.');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': infoId,
      'title': title,
      'description': description,
      'description2': description2,
      'description3': description3,
      'description4': description4,
      'mainImageUrl': mainImageUrl,
      'images': images,
      'videoUrl': videoUrl,
      'infoType': infoType.name, // Store the name of the info type
    };
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    // Retrieve the InfoType based on the name stored in JSON
    InfoType type = json['infoType'] == 'Infographic'
        ? InfoType.infographic
        : InfoType.video;

    return Info(
      infoId: json['id'],
      title: json['title'],
      description: json['description'],
      description2: json['description2'],
      description3: json['description3'],
      description4: json['description4'],
      mainImageUrl: json['mainImageUrl'],
      images: List<String>.from(json['images']),
      videoUrl: json['videoUrl'] ?? '', // Default to an empty string if not present
      infoType: type,
    );
  }

  factory Info.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Info(
      infoId: data['id'],
      title: data['title'],
      description: data['description'],
      description2: data['description2'],
      description3: data['description3'],
      description4: data['description4'],
      mainImageUrl: data['mainImageUrl'],
      images: List<String>.from(data['images']),
      videoUrl: data['videoUrl'] ?? '', // Default to an empty string if not present
      infoType: data['infoType'] == 'Infographic'
          ? InfoType.infographic
          : InfoType.video,
    );
  }
}
