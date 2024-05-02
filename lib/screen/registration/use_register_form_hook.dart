import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum UserRole {
  doctor,
  patient,
}

RegisterFormData useRegisterForm(UserRole initialRole) {
  final fullName = useTextEditingController();
  final occupationCategory = useTextEditingController();
  final contactNumber = useTextEditingController();
  final smsCode = useTextEditingController();
  //
  final email = useTextEditingController();
  final password = useTextEditingController();
  final confirmationPassword = useTextEditingController();
  final medicalId = useTextEditingController();
  final hospitalBranch = useTextEditingController();
  final role = useState<UserRole>(initialRole);
  //

  return RegisterFormData(
    fullName: fullName,
    occupationCategory: occupationCategory,
    contactNumber: contactNumber,
    smsCode: smsCode,
    email: email,
    password: password,
    confirmationPassword: confirmationPassword,
    hospitalBranchName: hospitalBranch,
    medicalId: medicalId,
    role: role.value,
  );
}

class RegisterFormData {
  final TextEditingController fullName;
  final TextEditingController occupationCategory;
  final TextEditingController contactNumber;
  final TextEditingController smsCode;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmationPassword;
  final TextEditingController hospitalBranchName;
  final TextEditingController medicalId;
  final UserRole role;

  RegisterFormData(
      {required this.fullName,
      required this.occupationCategory,
      required this.contactNumber,
      required this.smsCode,
      required this.email,
      required this.password,
      required this.confirmationPassword,
      required this.hospitalBranchName,
      required this.medicalId,
      required this.role});
}
