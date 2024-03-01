class ApiUrl{
  static String apiKey = '30099d4c210a4289b8bc9a9e6430ecb1';
  static String baseUrl = 'https://newsapi.org/v2';
  static String allNewsUrl = '$baseUrl/top-headlines?language=en&country=us&apiKey=$apiKey';
  static String allNewsCategoryUrl = '$baseUrl/top-headlines?language=en&category=business&apiKey=$apiKey';
}