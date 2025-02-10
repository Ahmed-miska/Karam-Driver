import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:karam_driver/core/networking/api_error_handler.dart';
import 'package:karam_driver/features/my_account/page_screen/data/model/get_page_response_model.dart';

import '../../../../core/networking/api_response.dart';
import '../data/repo/get_page_repo.dart';



class GetPageController extends GetxController {
  final GetPageRepo getPageRepo;

  GetPageController(this.getPageRepo);

  bool isLoading = false;
  bool isError = false;
  GetPageResponseModel? getPageResponseModel;
  var error = '';
  Future<ApiResponse> getPage(String page) async {
    isError = false;
    update();
    isLoading = true;
    update();
    var response = await getPageRepo.getPage(page);
    if (response.response != null && response.response!.statusCode == 200) {
      getPageResponseModel = GetPageResponseModel.fromJson(response.response!.data);
      update();
      isLoading = false;
      isError = false;
      update();
    } else {
      isLoading = false;
      isError = true;
      error = ApiErrorHandler.handle(response.error);
      update();
    }
    update();
    return response;
  }
}
