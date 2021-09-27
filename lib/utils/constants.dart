// ignore: avoid_classes_with_only_static_members
class KGlobal {
  // ignore: non_constant_identifier_names

  //Global constants
  static const TIME_OUT_DURATION = Duration(seconds: 10);
  static const CONNECT_TIMEOUT = 6000;
  static const RECEIVE_TIMEOUT = 6000;
}

class KPrefs {
  //Pref Constants
  static const TOKEN = 'token';
  static const IS_LOGGED_IN = 'is_logged_in';

  static const USER_ID = 'user_id';
  static const USER_EMAIL = 'user_email';
  static const MOBILE = 'mobile';
  static const USER_NAME = 'user_name';
  static const FCM_TOKEN = 'fcm_token';
  static const IMAGE = 'image';
}

class KReqHeaders {
  static const AUTHORIZATION = 'Authorization';
  static const DEVICE_TYPE = 'device_type';
  static const PLATFORM = 'Platform';
}

class KApiResponseCodes {
  static const int STATUS_SERVICE_UNAVAILABLE = 503;
}

class KApiBase {
  static const BASE_URL = 'http://www.counsellorinmeerut.com/admin/';
  static const SERVICE_BASE_URL =
      'http://www.counsellorinmeerut.com/admin/Service_api/';
  static const API_ORDER_PAY = BASE_URL + 'OrderPay.php?id=';
  static const API_PAY_RESPONSE = BASE_URL + 'PayResponse.php';
  static var razorPayApiKey = 'paymentgateway_list';
  // 'rzp_test_ozgtkcuMPXPF9x'; //  rzp_live_trKar7jRYrGtQ6

}

class KApiEndPoints {
  static const API_LOGIN = 'login';
  static const API_FORGOT = 'Forgotpassword';
  static const API_SEND_OTP = 'api/user/sendOtp';
  static const API_VERIFY_OTP = 'api/user/verifyOtp';
  static const app_dynamic_setting = 'app_dynamic_setting';
  static const get_profile = 'get_profile';
  static const user_update_profile = 'user_update_profile';
  static const Check_plan_expire = 'Check_plan_expire';
  static const Get_services = 'Get_services';
  static const MySubscriptionPlan = 'MySubscriptionPlan';
  static const Get_sub_services = 'Get_sub_services';
  static const Get_Plan_Package = 'Get_Plan_Package';
  static const video_list = 'video_list';
  static const PDF_list = 'PDF_list';
  static const API_SIGN_UP = 'sign_up';
  static const CheckPromoCode = 'CheckPromoCode';
  static const PurchasePackagePlan = 'PurchasePackagePlan';

  static const update_password = 'api/user/password/update';
}

class KDateFormats {
  static const DATE_FORMAT_1 = 'yyyy-MM-dd';
  static const DATE_FORMAT_2 = 'yyyy/MM/dd';
  static const DATE_FORMAT_3 = 'dd/MM/yyyy';
  static const DATE_FORMAT_4 = 'EEEE, d MMMM';
  static const DATE_FORMAT_5 = "d' 'MMM' '''yy";
  static const DATE_FORMAT_6 = 'dd MMM';
  static const DATE_FORMAT_7 = 'hh:mm a';
  static const DATE_FORMAT_8 = 'EEEE, MMMM d';
  static const DATE_FORMAT_9 = 'MMMM yyyy';
  static const DATE_FORMAT_10 = 'ddMMyy';
}

class SharedPrefsKeys {
  static const USER_ID = 'TOKEN';
  static const USER_LOGGED_IN = 'USER_LOGGED_IN';
  static const USER_TOKEN = 'USER_TOKEN';
  static const USER_REFERRAL = 'USER_REFERRAL';
  static const USER_PINCODE = 'USER_PINCODE';
  static const USER_ADDRESS = 'Address';
  static const FIRST_TIME_LAUNCH = 'first_time_launch';
  static const CART_ITEM_COUNT = "user_data";
  static const USER_ACCESS_KEY = 'access_key';
  static const PRIVACY_POLICY = 'privacy_policy';
  static const TERMS_CONDITION = 'terms_condition';
  static const CONTACT_US = 'contact_us';
  static const ABOUT_US = 'about_us';
}

class KNotificationTypes {
  static const POST_REACTION = 'Order';
  static const NOTIFICATION = 'Notification';
  static const FOLLOW = 'follow';
}
