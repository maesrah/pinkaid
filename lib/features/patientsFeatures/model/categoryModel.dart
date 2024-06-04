import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  bool isFeatured;
  String parentId;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.isFeatured,
      required this.parentId});

  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', isFeatured: false, parentId: '');

  Map<String, dynamic> toJson() {
    return {'Name': name, 'IsFeatured': isFeatured, 'ParentId': parentId};
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] as String,
        name: json['Name'] as String,
        parentId: json['ParentId'] as String,
        isFeatured: json['IsFeatured'] as bool);
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      name: data['Name'] as String,
      parentId: data['ParentId'] as String,
      isFeatured: data['IsFeatured'] as bool,
    );
  }
}
