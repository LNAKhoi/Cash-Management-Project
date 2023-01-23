class Validator {
  static bool isValidEmail(String email) {
    String emailRegrexPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool isValid = RegExp(emailRegrexPattern).hasMatch(email);
    if (!isValid || email.isEmpty) {
      return false;
    }
    return isValid;
  }

  static bool isValidPassword(String password) {
    if (password.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  static bool isValidName(String name) {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }
}
