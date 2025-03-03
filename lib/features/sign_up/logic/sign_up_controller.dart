import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/binging_helper.dart';
import 'package:karam_driver/core/networking/api_response.dart';
import '../../../core/networking/api_error_handler.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../data/models/areas_list_model.dart';
import '../data/models/sign_up_request_model.dart';
import '../data/models/sign_up_response_model.dart';
import '../data/repo/sign_up_repo.dart';

class SignUpController extends GetxController {
  final SignUpRepo signUpRepo;
  List<AreasItem> areasList = [];

  SignUpController(this.signUpRepo);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController workplaceController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode workplaceFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  String areaID = '1'.obs.toString();

  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var selectedCity = ''.obs;
  String lat = '';
  String long = '';

  SignUpResponseModel? signUpResponseModel;
  AreasListResponseModel? areasListResponseModel;
  var error = '';
  @override
  void onInit() async {
    addressController.text = 'بابل - الحلة';
    super.onInit();
  }

  Future<void> getAreasList(int page, String keyword) async {
    error = '';
    update();
    ApiResponse response = await signUpRepo.getAreasList(page: page, keyword: keyword);
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        if (response.response!.data['response_data'] != '') {
          areasListResponseModel = AreasListResponseModel.fromJson(response.response!.data);
          areasList.addAll(areasListResponseModel!.responseData!);
          update(); // Replace the list
          update();
        } else {
          error = 'لا يوجد منطقة مطابقة';
          update();
        }
      } else {
        customSnackbar('خطأ', response.response!.data['response_message']);
      }
    } else {
      customSnackbar('خطأ', 'خطاء فى تحميل المنطقة');
    }
  }

  Future<void> signUp() async {
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    ApiResponse response = await signUpRepo.signUp(
      SignUpRequestModel(
        fullName: nameController.text,
        mobile: phoneController.text,
        password: passwordController.text,      
        deleveryCompany: workplaceController.text,
        address: addressController.text,
       
      ),
    );
    Get.back();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        signUpResponseModel = SignUpResponseModel.fromJson(response.response!.data);
        if (signUpResponseModel != null && signUpResponseModel!.responseCode == 200) {
          customSnackbar('تم', signUpResponseModel!.responseMessage);
          Get.offAllNamed(AppRoutes.signInPage);
        } else {
          customSnackbar('خطأ', signUpResponseModel!.responseMessage);
        }
      } else {
        customSnackbar('خطأ', response.response!.data['response_message']);
      }
    } else {
      var error = ApiErrorHandler.handle(response.response);
      customSnackbar('خطأ', error.responseMessage!);
    }
  }

  // Future<void> fetchAndSetLocation() async {
  //   try {
  //     isLoading.value = true;
  //     Position position = await getCurrentPosition();
  //     lat = position.latitude.toString();
  //     long = position.longitude.toString();
  //     locationController.text = '$lat,$long';
  //   } catch (e) {
  //     customSnackbar('خطأ', e.toString()); // Show error message to the user
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // void liveLocation() {
  //   LocationSettings locationSettings = const LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );

  //   Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
  //     lat = position.latitude.toString();
  //     long = position.longitude.toString();
  //     locationController.text = 'lat: $lat,long: $long';
  //   });
  // }
}
