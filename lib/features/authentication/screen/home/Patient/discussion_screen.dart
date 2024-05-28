import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class DiscussionScreen extends StatelessWidget {
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Category 1', 'icon': Icons.category},
      {'name': 'Category 2', 'icon': Icons.star},
      {'name': 'Category 3', 'icon': Icons.access_alarm},
      {'name': 'Category 4', 'icon': Icons.account_balance},
      // Add more categories as needed
    ];
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Discussion'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchWidget(),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              Text(
                'Popular Categories',
                style: KTextTheme.lightTextTheme.headlineSmall,
              ),
              const SizedBox(
                height: kSpaceSectionSm,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return CategoriesWidget(
                      categoryName: category['name'],
                      icon: category['icon'],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: kSpaceSectionSm,
              ),
            ],
          ),
        ),
      ),
    );
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
      width: MediaQuery.of(context).size.width,
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
