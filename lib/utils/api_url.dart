class ApiUrl {
  // image url
  static String imageNotFound =
      'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=996';
  static String defaultProfile =
      'https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg';

  static String videoUrl =
      'https://live-par-2-abr.livepush.io/vod/bigbuckbunnyclip.mp4';

  // New API URL
  static String newBaseUrl = 'http://aminn.reigeeky.com/api';
  // static String newBaseUrl = 'https://quikkbyte.com/api';
  // static String newBaseUrl = '192.168.40.38/Am_inn/public/api';
  // static String newBaseUrl = 'https://66.29.145.160/public/api';
  static String imageBaseUrl = 'https://quikkbyte.com/';
  static String allNewsUrl = '$newBaseUrl/news';
  static String newLoginUrl = '$newBaseUrl/login';
  static String newLogOutUrl = '$newBaseUrl/logout';
  static String newRegisterUrl = '$newBaseUrl/register';
  static String newForgotPasswordUrl = '$newBaseUrl/forgot-password';
  static String newResetPasswordUrl = '$newBaseUrl/reset-password';
  static String newVerifyAccountUrl = '$newBaseUrl/account-verify';
  static String newUserProfileUrl = '$newBaseUrl/profile/details';

  static String newAddBookMark = "$newBaseUrl/bookmark_news/add";
  static String newAllBookMark = "$newBaseUrl/bookmark_news/";
  static String newUserUpdateUrl = "$newBaseUrl/user/update";
  static String newStoryUrl = "$newBaseUrl/story-boards";
  static String newCategoryUrl = "$newBaseUrl/categories-list";

  static String storeNotification = "$newBaseUrl/firebase/token/add";
  static String firebaseTokenUrl = "$newBaseUrl/firebase/token/get";
}
