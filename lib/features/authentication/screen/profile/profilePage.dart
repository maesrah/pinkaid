import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';
import 'package:pinkaid/features/authentication/screen/profile/widget/profileMenu.dart';
import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/authentication/widget/circular_image.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/images_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    String role = controller.user.value.role.toString();
    String roleName = role.split('.').last;
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const KCircularImage(
                      image: KImages.userImage,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
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
                  onPressed: () {}),
              ProfileMenu(
                  title: S.of(context).nameLabel,
                  value: controller.user.value.fullName,
                  onPressed: () {}),
              ProfileMenu(title: 'Role', value: roleName, onPressed: () {}),
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
            ],
          ),
        ),
      ),
    );
  }
}
