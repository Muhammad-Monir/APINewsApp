class ApiUrl {
  // news api
  static String imageNotFound =
      'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=996';
  static String defaultProfile =
      'https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg';

  static String apiKey = '30099d4c210a4289b8bc9a9e6430ecb1';

  // static String apiKey = '3f07d20249324058985a865638e6190c';
  static String newsBaseUrl = 'https://newsapi.org/v2';
  static String allNewsCategoryUrl =
      '$newsBaseUrl/top-headlines?language=en&apiKey=$apiKey';

  // static String allNewsUrl =
  //     '$newsBaseUrl/top-headlines?language=en&apiKey=$apiKey';
  static String searchUrl = '$newsBaseUrl/everything?apiKey=$apiKey';

  // User api
  static String baseUrl = 'http://newsapp.reigeeky.com/';
  static String loginUrl = '${baseUrl}api/login';
  static String logoutUrl = '${baseUrl}api/logout';
  static String userProfileUrl = '${baseUrl}api/user';
  static String registerUrl = '${baseUrl}api/register';
  static String accountVerifyUrl = "${baseUrl}api/account-verify";
  static String storyUrl = "${baseUrl}api/story-board";
  static String bookmarkUrl = "${baseUrl}api/bookmark_news/8";
  static String accountForgotUrl = "${baseUrl}api/forgot-password";
  static String accountResetUrl = "${baseUrl}api/reset-password";
  static String addBookMark = "${baseUrl}api/bookmark_news/add";
  static String allBookMark = "${baseUrl}api/bookmark_news/";

  // New API URL
  static String newBaseUrl = 'http://192.168.40.38/Am_inn/public/api';
  static String imageBaseUrl = 'http://192.168.40.38/Am_inn/public/';
  static String allNewsUrl = '$newBaseUrl/news';
  static String newLoginUrl = '$newBaseUrl/login';
  static String newLogOutUrl = '$newBaseUrl/logout';
  static String newRegisterUrl = '$newBaseUrl/register';
  static String newForgotPasswordUrl = '$newBaseUrl/forgot-password';
  static String newResetPasswordUrl = '$newBaseUrl/reset-password';
  static String newVerifyAccountUrl = '$newBaseUrl/account-verify';
  static String newUserProfileUrl = '$newBaseUrl/profile/details';
  static String newStoryUrl = "$newBaseUrl/story-board";
  static String newAddBookMark = "$newBaseUrl/bookmark_news/add";
  static String newAllBookMark = "$newBaseUrl/bookmark_news/";
  static String newUserUpdateUrl = "$newBaseUrl/user/update";


}
