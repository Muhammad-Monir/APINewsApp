import 'dart:convert';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../model/bookmark_model.dart';
import '../services/auth_service.dart';

class UserData{
  // Get profile data
  static Future<ProfileModel> userProfile(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.userProfileUrl),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 36|e6Lvo2IdS51yEAMJ66z45HnPMCKpO1znYte2LoQ1efbb063b'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ProfileModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception('code  ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception('Exception : $error');
    }
  }
  
  // Save user id
  static Future<void> getUserId(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.userProfileUrl),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 36|e6Lvo2IdS51yEAMJ66z45HnPMCKpO1znYte2LoQ1efbb063b'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['data']['id']);
        AuthService.saveUserId(data['data']['id']);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception('code  ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception('Exception : $error');
    }
  }

  // Add to bookmark
  static Future<BookMarkModel> addBookMark(String? authToken, String? userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://newsapp.reigeeky.com/api/bookmark_news/8'),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return BookMarkModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception(response.statusCode);
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception(error);
    }
  }


  // Get All bookmark
  static Future<BookMarkModel> fetchBookMark(String? authToken) async {
    try {
      final response = await http.get(
        Uri.parse('http://newsapp.reigeeky.com/api/bookmark_news/8'),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return BookMarkModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception(response.statusCode);
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception(error);
    }
  }
}












// class UserProvider with ChangeNotifier {
//   bool _isLoading = false;
//
//   bool get isLoading => _isLoading;
//
//
//   Future<ProfileModel> userProfile(String authToken, BuildContext context) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//       // Make a POST request to your login API endpoint
//       final response = await http.get(
//         Uri.parse(ApiUrl.loginUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $authToken'
//         },
//       );
//
//       // Check if the request was successful (status code 200)
//       if (response.statusCode == 200) {
//         _isLoading = false;
//         notifyListeners();
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         print(data);
//         // Utils.showSnackBar(context, data["message"]);
//         return ProfileModel.fromJson(data);
//       } else  {
//         // If the request was unsuccessful, throw an error
//         throw Exception('Failed to login');
//       }
//     } catch (error) {
//       // Handle errors, e.g., display an error message
//       Utils.showSnackBar(context, "$error");
//       rethrow;
//     }
//   }
//
//   _navigateToHome(BuildContext context){
//     Navigator.pushNamedAndRemoveUntil(
//       context,
//       RoutesName.bottomNavigationBar,
//           (route) => false,
//     );
//   }
// }

