import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinkaid/features/patientsFeatures/model/category_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';

class KDummyData {
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Stories',
      isFeatured: true,
      parentId: '',
    ),
    CategoryModel(
      id: '2',
      name: 'Breast Cancer',
      isFeatured: true,
      parentId: '',
    ),
    CategoryModel(
      id: '3',
      name: 'Detection and Diagnosis',
      isFeatured: true,
      parentId: '',
    ),
    CategoryModel(
      id: '4',
      name: 'Treatment Options',
      isFeatured: true,
      parentId: '',
    ),
    CategoryModel(
      id: '5',
      name: 'Side Effects',
      isFeatured: false,
      parentId: '',
    ),
    CategoryModel(
      id: '6',
      name: 'Living with Breast Cancer',
      isFeatured: false,
      parentId: '',
    ),
    CategoryModel(
      id: '7',
      name: 'Survivorship',
      isFeatured: false,
      parentId: '',
    ),
    CategoryModel(
      id: '8',
      name: 'Support',
      isFeatured: false,
      parentId: '',
    ),
  ];

  static final List<Post> posts = [
    // Survival Stories About Breast Cancer
    Post(
      id: '1',
      fullName: 'Alice Smith',
      postId: '1',
      title: 'My Journey to Survival',
      caption: 'A story of hope and resilience.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 10))),
      postUrl:
          'https://images.pexels.com/photos/579474/pexels-photo-579474.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/579474/pexels-photo-579474.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '1',
    ),
    Post(
      id: '2',
      fullName: 'Betty White',
      postId: '2',
      title: 'Overcoming Breast Cancer',
      caption: 'Sharing my experience and support.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 5))),
      postUrl:
          'https://images.pexels.com/photos/3822777/pexels-photo-3822777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/3822777/pexels-photo-3822777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '1',
    ),

    // Breast Cancer
    Post(
      id: '3',
      fullName: 'Charlie Brown',
      postId: '3',
      title: 'Understanding Breast Cancer',
      caption: 'An overview of breast cancer.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 8))),
      postUrl:
          'https://images.pexels.com/photos/5483017/pexels-photo-5483017.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/5483017/pexels-photo-5483017.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '2',
    ),
    Post(
      id: '4',
      fullName: 'David Johnson',
      postId: '4',
      title: 'Breast Cancer Facts',
      caption: 'Key information you need to know.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 3))),
      postUrl:
          'https://images.pexels.com/photos/7723582/pexels-photo-7723582.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/7723582/pexels-photo-7723582.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '2',
    ),

    // Detection and Diagnosis
    Post(
      id: '5',
      fullName: 'Eva Green',
      postId: '5',
      title: 'Early Detection Saves Lives',
      caption: 'The importance of early breast cancer detection.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 12))),
      postUrl:
          'https://images.pexels.com/photos/3759245/pexels-photo-3759245.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/3759245/pexels-photo-3759245.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '3',
    ),
    Post(
      id: '6',
      fullName: 'Frank Miller',
      postId: '6',
      title: 'Diagnosing Breast Cancer',
      caption: 'How breast cancer is diagnosed.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 7))),
      postUrl:
          'https://images.pexels.com/photos/5910758/pexels-photo-5910758.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/5910758/pexels-photo-5910758.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '3',
    ),

    // Treatment
    Post(
      id: '7',
      fullName: 'Grace Lee',
      postId: '7',
      title: 'Breast Cancer Treatment Options',
      caption: 'An overview of treatment options.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 15))),
      postUrl:
          'https://images.pexels.com/photos/6303699/pexels-photo-6303699.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/6303699/pexels-photo-6303699.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '4',
    ),
    Post(
      id: '8',
      fullName: 'Henry Kim',
      postId: '8',
      title: 'Managing Treatment Side Effects',
      caption: 'Tips for managing side effects of treatment.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 9))),
      postUrl:
          'https://images.pexels.com/photos/7723539/pexels-photo-7723539.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      profImage:
          'https://images.pexels.com/photos/7723539/pexels-photo-7723539.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      categoryId: '4',
    )
  ];
}
