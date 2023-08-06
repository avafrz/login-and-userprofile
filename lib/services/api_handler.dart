import 'dart:convert';
import '../model/users.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiHandler {
  Future<List<Users>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("http://fakestoreapi.com/users"),
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List tempList = [];
      for (var v in data) {
        tempList.add(v);
      }
      return Users.usersFromJson(tempList);
    } else {
      throw Exception('user not register');
    }
  }
}
