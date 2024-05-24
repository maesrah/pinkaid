class KValidator {
  static String? validateEmptyText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your name';
    }

    final nameRegExp = RegExp(r'^[a-z A-Z]+$');

    if (!nameRegExp.hasMatch(value)) {
      return 'Invalid name';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at east 6 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? samePassword(String? value, String? realPass) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value != realPass) {
      return 'Password is not the same';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    final phoneRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid number';
    }

    return null;
  }
}
