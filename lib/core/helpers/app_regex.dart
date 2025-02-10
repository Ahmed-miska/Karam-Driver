class AppRegex {
  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^07\d{9}$').hasMatch(phoneNumber);
  }
}
