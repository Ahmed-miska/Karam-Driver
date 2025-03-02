class ApiConstants {
  static const String apiBaseUrl = "https://3talabplus.com/app";
  static const String signIn = '/api/drivers/login';
  static const String signUp = '/api/drivers/register';
  static const String addAddress = '/api/clients/add_address';
  static const String areasList = '/api/drivers/areas_list';
  static const String activeUser = '/api/clients/activate_user';
  static const String forgetPassword = '/api/drivers/forget_password';
  static const String activeForgetPassword = '/api/drivers/activate_forget_user';
  static const String renewPassword = '/api/drivers/renew_password';
  static const String getShowCommercialNotifications = '/api/clients/show_commercial_notifications';
  static const String getPage = '/api/pages/get_page';
  static const String contactUs = '/api/contact_us/send';
  static const String getOrders = '/api/drivers_orders/my_orders';
  static const String getOrderDetails = '/api/drivers_orders/order_details';
  static const String cancelOrder = '/api/clients_orders/change_order_status';
  static const String orederStatus = '/api/drivers_orders/order_status';
  static const String searchClient = '/api/drivers_orders/search_client';
  static const String uploadDoorPhoto = '/api/drivers_orders/upload_door_photo';
  static const String changeOrderStatus = '/api/drivers_orders/change_order_status';
  static const String sendMapLink = '/api/drivers_orders/send_map_link';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
