import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinkaid/features/patientsFeatures/model/category_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/meal_model.dart';
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

  static final List<Doctor> doctors=[
  Doctor(id: '1', fullName: 'Prof. Dr. See Mee Hong', 
  position: 'Consultant Oncoplastic Breast Surgeon ',
  workExperience: 'Senior lecturer at the University of Malaya and a dedicated Consultant Oncoplastic Breast Surgeon at the University Malaya Medical Center (UMMC).', 
  hospitalWork: 'University Malaya Medical Center',
   profImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS66XUi38dXAVod2yiDUtZNYrBPIk1Y6DDMqrkfX8u_cKz4hlxGy91cs1NZeGLihUAwf9M&usqp=CAU', phoneNumber: '', profilePicture: '', blockedDates: [],
  ),
  Doctor(id: '2', fullName: 'Dr. Lai Lee Lee',
  position: 'Clinical Researcher in Oncoplastic Breast Unit',
   workExperience: 'Senior lecturer at Universiti Malaya and Clinical Researcher in Oncoplastic Breast Unit at Universiti Malaya Medical Center (UMMC)',
   hospitalWork: 'University Malaya Medical Center', 
   profImage:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyLTqn7T8NgjzV5t-jutsKsMfd16-B8zMsqfptTEcIZ_4FMmmSM4EjITq8RZzps0yodSE&usqp=CAU', phoneNumber: '', profilePicture: '', blockedDates: []),

  Doctor(id: '3', fullName:'Prof. Dr. Kartini Binti Rahmat',
  position: 'Breast Cancer Imaging', 
  workExperience: 'Head o University of Malaya Research Imaging Centre', 
  hospitalWork: 'Universit Malaya Medical Centre', 
  profImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx8brqt8Uvy88TXV7KiFKjIo48KUdTd5g5LvnuOwZtsxFNv1yGUn7KNmaD6wvp7ax1RvY&usqp=CAU', 
  phoneNumber: '', profilePicture: '', blockedDates: [])
];

static final List<Meal> dummyMeals = [
  Meal(id: '1', mealName: 'Chicken Salad', nutrient: 30, calories: 350),
  Meal(id: '2', mealName: 'Grilled Salmon', nutrient: 40, calories: 500),
  Meal(id: '3', mealName: 'Quinoa Bowl', nutrient: 25, calories: 300),
  Meal(id: '4', mealName: 'Vegetable Stir Fry', nutrient: 20, calories: 250),
  Meal(id: '5', mealName: 'Beef Tacos', nutrient: 35, calories: 450),
  Meal(id: '6', mealName: 'Greek Yogurt Parfait', nutrient: 15, calories: 200),
  Meal(id: '7', mealName: 'Egg Omelette', nutrient: 28, calories: 400),
  Meal(id: '8', mealName: 'Tofu Curry', nutrient: 22, calories: 320),
  Meal(id: '9', mealName: 'Pasta Primavera', nutrient: 18, calories: 370),
  Meal(id: '10', mealName: 'Fruit Smoothie', nutrient: 10, calories: 180),
  Meal(id: '11', mealName: 'Chickpea Salad', nutrient: 30, calories: 280),
  Meal(id: '12', mealName: 'Turkey Sandwich', nutrient: 25, calories: 350),
  Meal(id: '13', mealName: 'Steak and Potatoes', nutrient: 50, calories: 700),
  Meal(id: '14', mealName: 'Sushi Rolls', nutrient: 15, calories: 250),
  Meal(id: '15', mealName: 'Lentil Soup', nutrient: 28, calories: 210),
  Meal(id: '16', mealName: 'Cobb Salad', nutrient: 32, calories: 450),
  Meal(id: '17', mealName: 'Hummus and Veggies', nutrient: 20, calories: 220),
  Meal(id: '18', mealName: 'Baked Ziti', nutrient: 25, calories: 400),
  Meal(id: '19', mealName: 'Shrimp Tacos', nutrient: 30, calories: 420),
  Meal(id: '20', mealName: 'Veggie Burger', nutrient: 18, calories: 350),
  Meal(id: '21', mealName: 'Pancakes', nutrient: 10, calories: 300),
  Meal(id: '22', mealName: 'Caesar Salad', nutrient: 15, calories: 250),
  Meal(id: '23', mealName: 'Chicken Alfredo', nutrient: 40, calories: 600),
  Meal(id: '24', mealName: 'Roasted Vegetables', nutrient: 22, calories: 200),
  Meal(id: '25', mealName: 'Fruit Salad', nutrient: 12, calories: 150),
];

}


