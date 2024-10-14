import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';
import 'package:pinkaid/features/authentication/screen/profile/profilePage.dart';
import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/features/patientsFeatures/screen/chatbot_screen.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/first_onboarding_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/post_card.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class PatientsHomePage extends StatelessWidget {
  const PatientsHomePage({super.key});
  static const String routeName = 'PatientsHomePage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const PatientsHomePage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());
    final usercontroller = Get.put(UserController());
    final List<Post> posts = controller.homePost;
    final List<String> myImages = [
      'assets/stats/img1.jpg',
      'assets/stats/img2.jpg',
      'assets/stats/img3.jpg',
      // Add more image paths as needed
    ];

    final List<Map<String, dynamic>> healthItems = [
      {
        'image': 'assets/icons/breast-cancer.png',
        'title': 'Breast Cancer Symptom'
      },
      {
        'image': 'assets/icons/breast-cancer (1).png',
        'title': 'Breast Cancer Risk Factor'
      },
      {
        'image': 'assets/icons/chemotherapy.png',
        'title': 'Breast Cancer Surgery'
      },
      {
        'image': 'assets/icons/breast-lump.png',
        'title': 'Breast Reconstruction'
      },
      {'image': 'assets/icons/mammography.png', 'title': 'Chemotherapy'},
      {'image': 'assets/icons/pink-ribbon.png', 'title': 'About us'},
      // Add more items as needed
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.question_circle))
        ],
        leading: IconButton(
            onPressed: () {
              Get.to(() => const ProfileScreen());
            },
            icon: const Icon(CupertinoIcons.profile_circled)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (usercontroller.showAlert.value &&
                    !usercontroller.fillInForm.value) {
                  // Show AlertDialog without replacing any content
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Attention'),
                        content: const Text(
                            'You need to fill in the medical form to proceed.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              usercontroller.hideAlert(); // Hide alert
                              Navigator.of(context).pop();
                              Get.to(() =>
                                  FirstOnboardingPage()); // Navigate to your form page
                            },
                            child: const Text('Go to Form'),
                          ),
                          TextButton(
                            onPressed: () {
                              usercontroller.hideAlert(); // Hide alert
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  });
                }
                return const SizedBox.shrink();
              }),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).helloLabel,
                      style: KTextTheme.lightTextTheme.headlineMedium,
                    ),
                    Obx(() {
                      if (usercontroller.profileLoading.value) {
                        return const Center();
                      }

                      return Text(
                        usercontroller.user.value.fullName,
                        style: KTextTheme.lightTextTheme.headlineMedium,
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  viewportFraction: 1,
                  height: 220,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayInterval: const Duration(seconds: 3),
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    usercontroller.updateIndex(index);
                  },
                ),
                items: myImages.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColorLight,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Carousel Indicator
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: myImages.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => usercontroller.updateIndex(entry.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: usercontroller.currentIndex.value == entry.key
                            ? 12.0
                            : 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: usercontroller.currentIndex.value == entry.key
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      offset: const Offset(
                          0.1, 0.1), // Position of the shadow (x, y)
                      blurRadius: 0.5, // Blur effect
                      spreadRadius: 2, // Spread radiu
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kSpaceScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Breast Health',
                        style: KTextTheme.lightTextTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: kSpaceInput,
                      ),
                      LayoutBuilder(builder: (context, boxConstraints) {
                        const double spacing = 8.0;
                        const int numberOfItemsPerRow = 4;
                        final boxWidth = boxConstraints.maxWidth;
                        final availableWidthAfterDeductSpace =
                            boxWidth - (spacing * (numberOfItemsPerRow - 1));
                        final widgetSize = availableWidthAfterDeductSpace /
                            numberOfItemsPerRow;
                        return Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: healthItems.map((item) {
                            return SizedBox(
                              width: widgetSize,
                              child: HealthWidget(
                                imagePath: item['image'],
                                title: item['title'],
                              ),
                            );
                          }).toList(),
                        );
                      })
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: kSpaceScreenPadding,
                    vertical: kSpaceScreenPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      offset: const Offset(
                          0.1, 0.1), // Position of the shadow (x, y)
                      blurRadius: 0.5, // Blur effect
                      spreadRadius: 2, // Spread radiu
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/stats/img5.jpg',
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: kSpaceScreenPadding,
                    ),
                    Text(
                      'Make a consultation session to receive medical opinion!',
                      style: KTextTheme.lightTextTheme.titleSmall,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).bookConsultTitle,
                          style: KTextTheme.lightTextTheme.bodySmall,
                        ),
                        const Icon(Iconsax.arrow_right_3_copy)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSpaceScreenPadding,
                            vertical: kSpaceScreenPadding),
                        decoration: BoxDecoration(
                            color: kColorSecondaryLight,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Iconsax.document_favorite_copy,
                              size: 50,
                            ),
                            Text(
                              S.of(context).journeyHeader,
                              style: KTextTheme.lightTextTheme.titleSmall,
                            ),
                            Text(
                              S.of(context).journeySub,
                              style: KTextTheme.lightTextTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSpaceScreenPadding,
                            vertical: kSpaceScreenPadding),
                        decoration: BoxDecoration(
                            color: kColorPrimaryLight,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Iconsax.game_copy,
                              size: 50,
                            ),
                            Text(
                              S.of(context).quizHeader,
                              style: KTextTheme.lightTextTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).discussionTitle),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_right_1_copy))
                ],
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                }
                return posts.isEmpty
                    ? const Text('No data')
                    : SizedBox(
                        height: 355,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: posts.map((post) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: PostCard(post: post),
                            );
                          }).toList(),
                        ),
                      );
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(const ChatbotScreen());
        },
        label: const Icon(Iconsax.message_question_copy),
        tooltip: 'Need Assistant?',
      ),
    );
  }
}

class HealthWidget extends StatelessWidget {
  const HealthWidget({
    super.key,
    required this.imagePath,
    required this.title,
  });
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25, // Adjust the radius as needed
            backgroundColor:
                kColorSecondaryLight, // Set background color if needed
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width:
                    40, // Set width and height to match the CircleAvatar's diameter
                height: 40,
                fit: BoxFit.cover, // Ensures the image covers the circular area
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class DiscussionWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl; // Image URL can be null

  const DiscussionWidget({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
      decoration: BoxDecoration(
          color: kColorPrimaryLight, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null) // Check if imageUrl is not null
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // You can adjust the height as needed
              ),
            ),
          Text(
            title,
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          Text(
            description,
            style: KTextTheme.lightTextTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
