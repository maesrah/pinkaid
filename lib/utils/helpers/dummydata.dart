import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinkaid/features/patientsFeatures/model/categoryModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/postModel.dart';

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
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 10))),
      postUrl: 'assets/images/pexels1.jpg',
      profImage: 'assets/images/pexels1.jpg',
      likes: [],
      categoryId: '1',
    ),
    Post(
      id: '2',
      fullName: 'Betty White',
      postId: '2',
      title: 'Overcoming Breast Cancer',
      caption: 'Sharing my experience and support.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 5))),
      postUrl: 'assets/images/pexels2.jpg',
      profImage: 'assets/images/pexels2.jpg',
      likes: [],
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
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 8))),
      postUrl: 'assets/images/pexels3.jpg',
      profImage: 'assets/images/pexels3.jpg',
      likes: [],
      categoryId: '2',
    ),
    Post(
      id: '4',
      fullName: 'David Johnson',
      postId: '4',
      title: 'Breast Cancer Facts',
      caption: 'Key information you need to know.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 3))),
      postUrl: 'assets/images/pexels4.jpg',
      profImage: 'assets/images/pexels4.jpg',
      likes: [],
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
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 12))),
      postUrl: 'assets/images/pexels5.jpg',
      profImage: 'assets/images/pexels5.jpg',
      likes: [],
      categoryId: '3',
    ),
    Post(
      id: '6',
      fullName: 'Frank Miller',
      postId: '6',
      title: 'Diagnosing Breast Cancer',
      caption: 'How breast cancer is diagnosed.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 7))),
      postUrl: 'assets/images/pexels6.jpg',
      profImage: 'assets/images/pexels6.jpg',
      likes: [],
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
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 15))),
      postUrl: 'assets/images/pexels7.jpg',
      profImage: 'assets/images/pexels7.jpg',
      likes: [],
      categoryId: '4',
    ),
    Post(
      id: '8',
      fullName: 'Henry Kim',
      postId: '8',
      title: 'Managing Treatment Side Effects',
      caption: 'Tips for managing side effects of treatment.',
      datePublished:
          Timestamp.fromDate(DateTime.now().subtract(Duration(days: 9))),
      postUrl: 'assets/images/pexels8.jpg',
      profImage: 'assets/images/pexels8.jpg',
      likes: [],
      categoryId: '4',
    )
  ];
}
