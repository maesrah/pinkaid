import "package:flutter/material.dart";
import "package:pinkaid/generated/l10n.dart";
import "package:pinkaid/theme/textheme.dart";
import "package:pinkaid/theme/theme.dart";
import "package:pinkaid/utils/constant/images_string.dart";

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: kColorSecondary,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(height: 100, image: AssetImage(KImages.appLogo)),
            Column(
              children: [
                Text(
                  S.of(context).welcomeBack,
                  style: KTextTheme.lightTextTheme.titleMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
