import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';
import 'package:pinkaid/features/authentication/screen/profile/updateUserProfile.dart';
import 'package:pinkaid/features/authentication/screen/profile/widget/profileMenu.dart';
import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/authentication/widget/circular_image.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/first_onboarding_page.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/images_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Obx(() {
            if (controller.profileLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final profileImage = networkImage.isNotEmpty
                            ? networkImage
                            : KImages.userImage;

                        return KCircularImage(
                          image: profileImage,
                          width: 80,
                          height: 80,
                          isNetworkImage: networkImage.isNotEmpty,
                        );
                      }),
                      TextButton(
                          onPressed: () {
                            controller.uploadProfilePicture();
                          },
                          child: const Text('Change Profile Picture'))
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: kSpaceScreenPadding),
                Text(
                  'Profile Information',
                  style: KTextTheme.lightTextTheme.headlineSmall,
                ),
                const SizedBox(height: kSpaceSectionSm),
                ProfileMenu(
                    title: S.of(context).phoneNo,
                    value: controller.user.value.phoneNumber,
                    onPressed: () {
                      Get.dialog(UpdateUserDialog(
                        field: 'phoneNumber',
                        initialValue: controller.user.value.phoneNumber,
                        userId: controller.user.value.id,
                      ));
                    }),
                ProfileMenu(
                    title: S.of(context).nameLabel,
                    value: controller.user.value.fullName,
                    onPressed: () {
                      Get.dialog(UpdateUserDialog(
                        field: 'fullName',
                        initialValue: controller.user.value.fullName,
                        userId: controller.user.value.id,
                      ));
                    }),
                Obx(() {
                  String role = controller.user.value.role.toString();

                  String roleName = role.split('.').last;
                  return ProfileMenu(
                      title: 'Role', value: roleName, onPressed: () {});
                }),

                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),

                Center(
                  child: TextButton(
                      onPressed: () {
                        controller.signOut();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: kColorPrimaryLight),
                      child: Text('Log out')),
                ),
                // TextButton(
                //     onPressed: () {
                //       controller.uploadCategoryData();
                //     },
                //     child: Text('Upload Categories')),
                // TextButton(
                //     onPressed: () {
                //       controller.uploadPostsData();
                //     },
                //     child: Text('Upload Posts'))
                // TextButton(
                //     onPressed: () {
                //       controller.uploadDoctorAPI();
                //     },
                //     child: Text('Upload Doctors'))
                TextButton(
                    onPressed: () {
                      Get.to(() => FirstOnboardingPage());
                    },
                    child: Text('OnboardingPage')),

                TextButton(
                    onPressed: () {
                      controller.uploadMealData();
                    },
                    child: Text('Upload Meals')),
                    TextButton(
                    onPressed: () {
                      controller.uploadQuizData();
                    },
                    child: Text('Upload Quiz'))
              ],
            );
          }),
        ),
      ),
    );
  }
}
