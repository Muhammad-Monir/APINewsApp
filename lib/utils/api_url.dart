class ApiUrl{

  static String imageNotFound = 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=996';
  static String apiKey = '30099d4c210a4289b8bc9a9e6430ecb1';
  static String newsBaseUrl = 'https://newsapi.org/v2';
  static String allNewsCategoryUrl = '$newsBaseUrl/top-headlines?language=en&apiKey=$apiKey';
  static String allNewsUrl = '$newsBaseUrl/top-headlines?language=en&apiKey=$apiKey';
  static String appBaseUrl = 'http://newsapp.reigeeky.com/';
  static String loginUrl = '${appBaseUrl}api/login';
  static String registerUrl = '${appBaseUrl}api/register';
  static String accountVerifyUrl = "${appBaseUrl}api/account-verify";


}