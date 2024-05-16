import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/features/authentication/screen/registration/use_register_form_hook.dart';
import 'package:pinkaid/features/authentication/screen/registration/verify_email.dart';
import 'package:pinkaid/theme/textheme.dart';

import 'package:pinkaid/theme/theme.dart';

class RegistrationBasicInfoPage extends StatefulWidget {
  const RegistrationBasicInfoPage({
    super.key,
  });
  static const String routeName = 'RegistrationBasicInfoPage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const RegistrationBasicInfoPage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<RegistrationBasicInfoPage> createState() =>
      _RegistrationBasicInfoPageState();
}

class _RegistrationBasicInfoPageState extends State<RegistrationBasicInfoPage> {
  bool _visible = false;
  final _formkey = GlobalKey<FormState>();
  String dropdownValue = 'doctor';
  UserRole? _selectedUserRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorSecondary,
        title: Text(
          S.of(context).registration,
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s create your account',
                  style: KTextTheme.lightTextTheme.headlineMedium,
                ),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return 'Enter correct name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.profile_tick),
                    hintText: S.of(context).nameLabel,
                    filled: true,
                    fillColor: Colors.white,
                    errorStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                TextFormField(
                  validator: (value) {
                    //a.aaba@aa1a_a.com
                    if (value!.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                            .hasMatch(value)) {
                      return 'Enter correct phone number';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.call),
                    hintText: S.of(context).phoneNo,
                    filled: true,
                    fillColor: Colors.white,
                    errorStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                  obscureText: _visible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: S.of(context).password,
                    errorStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                      child: Icon(
                          _visible ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                  obscureText: _visible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: S.of(context).confirmPass,
                    errorStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                      child: Icon(
                          _visible ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                DropdownButtonFormField<UserRole>(
                  value: _selectedUserRole,
                  onChanged: (UserRole? newValue) {
                    setState(() {
                      _selectedUserRole = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.people),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  items: [
                    // Add a default value to indicate selection is required
                    const DropdownMenuItem<UserRole>(
                      value: null,
                      child: Text('Select a role'),
                    ),
                    // Add enum values
                    ...UserRole.values.map((UserRole userRole) {
                      return DropdownMenuItem<UserRole>(
                        value: userRole,
                        child: Text(userRole.toString().split('.').last),
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                if (_selectedUserRole == UserRole.doctor)
                  TextFormField(
                    // validator: (value) {
                    //   if (value!.isEmpty ||
                    //       !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    //     return 'Enter correct name';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    decoration: const InputDecoration(
                      hintText: 'Medical Id',
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: kSpaceSectionSm,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).agreeLabel,
                            style: const TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: S.of(context).termAndCondition,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      minimumSize: MaterialStateProperty.resolveWith<Size>(
                        (states) => const Size(double.infinity, 50),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(EmailVerifyPage.route());
                      });
                    },
                    child: Text(
                      S.of(context).register,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
