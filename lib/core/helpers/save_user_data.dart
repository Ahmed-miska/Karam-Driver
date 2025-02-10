import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:karam_driver/core/helpers/app_constants.dart';
import 'package:karam_driver/features/sign_in/data/data/models/sign_in_response_model.dart';


class SaveUserData {
  static late GetStorage getStorage;
  static Future<void> init() async {
    getStorage = GetStorage();
    await GetStorage.init();
  }

  /// save SharedData
  Future<void> saveUserData(SignInResponseModel user) async {
    String userSavedData = json.encode(user.responseData!.user);
    try {
      await getStorage.write(AppConstants.userData, userSavedData);
      await saveUserToken(user.responseData!.token ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUserId(String userId) async {
    try {
      await getStorage.write(AppConstants.userid, userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUserToken(String userTOKEN) async {
    try {
      await getStorage.write(AppConstants.userTOKEN, userTOKEN);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateShowCommercialNotifications(String newValue) async {
    // Step 1: Read the saved user data
    final storedUserData = GetStorage().read(AppConstants.userData);

    if (storedUserData != null) {
      // Step 2: Decode the JSON string into a Dart object (Map)
      Map<String, dynamic> userData = json.decode(storedUserData);

      // Step 3: Modify the 'showCommercialNotifications' field
      userData['show_commercial_notifications'] = newValue;

      // Step 4: Encode the modified object back to a JSON string
      String updatedUserData = json.encode(userData);

      // Step 5: Save the updated JSON string back to GetStorage
      try {
        await GetStorage().write(AppConstants.userData, updatedUserData);
        print('User data updated successfully.');
      } catch (e) {
        print('Error saving updated user data: $e');
        rethrow; // You can choose to handle or rethrow the error
      }
    } else {
      print('No user data found to update.');
    }
  }

  // Future<void> saveTitle(String title) async {
  //   try {
  //     await sharedPreferences.setString(AppConstants.title, title);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  ///get SharedData
  User? getUserData() {
    String? userSavedData = getStorage.read(AppConstants.userData);
    if (userSavedData != null) {
      Map<String, dynamic> userData = json.decode(userSavedData);
      User userModel = User.fromJson(userData);
      return userModel;
    }
    return null;
  }

  String getUserToken() {
    return getStorage.read(AppConstants.userTOKEN) ?? "";
  }

  String getUserId() {
    return getStorage.read(AppConstants.userid) ?? "";
  }

  // String getLang() {
  //   return sharedPreferences.getString(AppConstants.lang) ?? "ar";
  // }

  /// check SharedData

  ///clear SharedData
  Future<bool> clearSharedData() async {
    await getStorage.erase();
    // await getStorage.remove(AppConstants.userData);
    // await getStorage.remove(AppConstants.userTOKEN);
    // await getStorage.remove(AppConstants.title);
    // await getStorage.remove(AppConstants.userAddress);
    return true;
  }

  Future<void> saveUserAddress(String address) async {
    try {
      await getStorage.write(AppConstants.userAddress, address);
    } catch (e) {
      rethrow;
    }
  }

  String getUserAddress() {
    return getStorage.read(AppConstants.userAddress) ?? "";
  }
}
