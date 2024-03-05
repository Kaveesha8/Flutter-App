import 'dart:convert';
 
import 'package:webapp/models/model.dart';
import 'package:http/http.dart' as http;
 
class ApiHandler {
  final String baseUri = "https://localhost:7283/api/Users";
 
  //method to handle get request
  Future<List<User>> getUserData() async {
    List<User> data = [];
    final uri = Uri.parse(baseUri); //store the response after API calls
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type' : 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode >=200 && response.statusCode <=299) {
        final List<dynamic> jsonData = json.decode(response.body);
        //convert json to user model object
        data= jsonData.map((json) => User.fromJson(json)).toList();  
        print(data);
      }
    } catch (e) {
      return data;
    }
    return data;
  }
 
  Future<http.Response> updateUser({required int userId, required User user}) async {
    final uri = Uri.parse("$baseUri/$userId");
    late http.Response response;
    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type' : 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user),
      );
     
    } catch (e) {
      return response;
    }
    return response;
  }
 
   Future<http.Response> addUser({required User user}) async {
    final uri = Uri.parse(baseUri);
    late http.Response response;
    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type' : 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user),
      );
     
    } catch (e) {
      return response;
    }
    return response;
  }
 
  Future<http.Response> deleteUser({required int userId}) async {
    final uri = Uri.parse("$baseUri/$userId");
    late http.Response response;
    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type' : 'application/json; charset=UTF-8'
        },
      );
     
    } catch (e) {
      return response;
    }
    return response;
  }
 
  Future<User> getUserById({required int userId}) async {
    User? user;
    final uri = Uri.parse("$baseUri/$userId"); //store the response after API calls
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type' : 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode >=200 && response.statusCode <=299) {
        final Map<String,dynamic> jsonData = json.decode(response.body);
        //convert json to user model object
        user = User.fromJson(jsonData);
      }else if(response.statusCode == 404){
        user = const User(
        id: 0,
        name: '',
        addresss: '',
      );
      }
    } catch (e) {
      return user!;
    }
    return user!;
  }
 
 
}