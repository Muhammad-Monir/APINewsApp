class ApiUrl{

  // news api
  static String imageNotFound = 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=996';
  // static String apiKey = '30099d4c210a4289b8bc9a9e6430ecb1';
  static String apiKey = '3f07d20249324058985a865638e6190c';
  static String newsBaseUrl = 'https://newsapi.org/v2';
  static String allNewsCategoryUrl = '$newsBaseUrl/top-headlines?language=en&apiKey=$apiKey';
  static String allNewsUrl = '$newsBaseUrl/top-headlines?language=en&apiKey=$apiKey';
  static String searchUrl = '$newsBaseUrl/everything?apiKey=$apiKey';

  // User api
  static String appBaseUrl = 'http://newsapp.reigeeky.com/';
  static String loginUrl = '${appBaseUrl}api/login';
  static String logoutUrl = '${appBaseUrl}api/logout';
  static String userProfileUrl = '${appBaseUrl}api/user';
  static String registerUrl = '${appBaseUrl}api/register';
  static String accountVerifyUrl = "${appBaseUrl}api/account-verify";
  static String storyUrl = "${appBaseUrl}api/story-board";
  static String bookmarkUrl = "${appBaseUrl}api/bookmark_news/8";
  static String accountForgotUrl = "${appBaseUrl}api/forgot-password";
  static String accountResetUrl = "${appBaseUrl}api/reset-password";
  static String addBookMark = "${appBaseUrl}api/bookmark_news/add";
  static String allBookMark = "${appBaseUrl}api/bookmark_news/";



}