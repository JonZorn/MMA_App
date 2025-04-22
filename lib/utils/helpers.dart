class Helpers {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }
    RegExp regExp = new RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!regExp.hasMatch(
      value!,
    )) {
      return "Email is invalid";
    }
    return null;
  }

  static String? validateEmpty(String? value, String? label) {
    if (value!.isEmpty) {
      return '$label is required';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value! != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateCurrentPassword(String? value, String? oldpassword) {
    if (value!.isEmpty) {
      return 'New Password is required';
    }
    if (value! == oldpassword) {
      return 'Password should not be same';
    }

    RegExp reguper = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$.!%*?&])[A-Za-z\d@$.!%*?&]{8,}$");
    if (!reguper.hasMatch(value!)) {
      return 'Password should consist of 8 to 20 characters and must contain at least one upper case, one lower case, one number, and one special character.';
    }
    if (value!.length < 8 || value!.length > 20) {
      return 'Password should be consist of 8 to 20 characters.';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    RegExp regExp = RegExp(r"^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$");

    if (!regExp.hasMatch(
      value!,
    )) {
      return "character is invalid";
    }
    return null;
  }

  static String? strengthPassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    RegExp reguper = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$.!%*?&])[A-Za-z\d@$.!%*?&]{8,}$");
    if (!reguper.hasMatch(value!)) {
      return 'Password should consist of 8 to 20 characters and must contain at least one upper case, one lower case, one number, and one special character';
    }

    if (value!.length < 8 || value!.length > 20) {
      return 'Password should be consist of 8 to 20 characters.';
    }
    return null;
  }
}
