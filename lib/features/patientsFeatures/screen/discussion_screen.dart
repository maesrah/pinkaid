import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:pinkaid/features/authentication/screen/home/Patient/patients_home_page.dart';
// import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/patientsFeatures/controller/category_controller.dart';

import 'package:pinkaid/features/patientsFeatures/screen/add_post_screen.dart';
import 'package:pinkaid/features/patientsFeatures/screen/post_page.dart';

import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class DiscussionScreen extends StatelessWidget {
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
           //backgroundColor: kColorPrimaryOne,
          automaticallyImplyLeading: false,
         
          title: const Text('Discussion'),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //search bar
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 70,
                            child: const SearchWidget()),
                        IconButton(
                            onPressed: () {
                              Get.to(() => const AddPostScreen());
                            },
                            icon: const Icon(Iconsax.add_circle)),
                      ],
                    ),

                    const SizedBox(
                      height: kSpaceScreenPadding,
                    ),
                    Text(
                      'Categories',
                      style: KTextTheme.lightTextTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: kSpaceSectionSm,
                    ),
                    const TabBarWidget()
                  ],
                ),
              )),
        ),
        body: Obx(() {
          if (categoryController.featuredCategories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: categoryController.featuredCategories
                .map((e) => PostsPage(
                      categoryId: e.id,
                    ))
                .toList(),
          );
        }),
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    // required this.categories,
  });

  //final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    // final List<CategoryModel> categories =
    //     categoryController.featuredCategories();

    return Obx(() {
      if (categoryController.featuredCategories.isEmpty) {
        return CircularPercentIndicator(radius: 10);
      }
      return TabBar(
        isScrollable: true,
        
        indicatorColor: kColorPrimaryOne,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: categoryController.featuredCategories
            .map((e) => Tab(
                  child: Text(e.name),
                ))
            .toList(),
      );
    });
  }
}

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {super.key, required this.icon, required this.categoryName});

  final String categoryName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
            color: kColorPrimaryLight, borderRadius: BorderRadius.circular(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              categoryName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: KTextTheme.lightTextTheme.labelSmall,
            )
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpaceSectionMd),
      decoration: BoxDecoration(
          color: kColorInfo,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          const Icon(
            Iconsax.search_normal_1_copy,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Search discussion',
            style: KTextTheme.lightTextTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
