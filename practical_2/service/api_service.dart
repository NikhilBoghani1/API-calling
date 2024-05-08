import 'dart:convert';
import 'package:api_calling_http/practical_2/model/user.dart';

import 'package:api_calling_http/practical_2/model/user_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String url = "https://reqres.in/api/users";

  static ApiService _instance = ApiService._internal();

  // factory constructor
  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<List<User>> getUserList() async {
    List<User> userList = [];

    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        // success
        print('response : ${response.body}');

        UserResponse userResponse =
        UserResponse.fromJson(jsonDecode(response.body));
        userList = userResponse.userList ?? [];
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Failed to load album');
    }

    return userList;
  }
}