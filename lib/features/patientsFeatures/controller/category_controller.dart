import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/categories/categories_repository.dart';
import 'package:pinkaid/features/patientsFeatures/model/category_model.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();

      allCategories.assignAll(categories);

      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured)
          .take(8)
          .toList());
    } catch (e) {
      KLoaders.errorSnackBar(title: 'Something went wrong.');
    } finally {
      isLoading.value = false;
    }
  }
}
