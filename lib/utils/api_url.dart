class ApiUrl{

  static String imageNotFound = 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=996';
  static String apiKey = '30099d4c210a4289b8bc9a9e6430ecb1';
  static String baseUrl = 'https://newsapi.org/v2';
  static String allNewsCategoryUrl = '$baseUrl/top-headlines?language=en&category=business&apiKey=$apiKey';
  static String allNewsUrl = '$baseUrl/top-headlines?language=en&apiKey=$apiKey';

}