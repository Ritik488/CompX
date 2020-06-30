import 'dart:convert';

import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Models/User/MainUser.dart';
import 'package:huncha/Models/User/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<bool> loginhttp(url, email, password) async {
  var response =
      await http.post(url, body: {"email": email, "password": password});
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    MainUser user = MainUser.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(user.token.toString());
    pref.setString('ltoken', user.token);
    pref.setString('Uresponse', json.encode(user));
    return true;
  }
  return false;
}

Future<String> signupHttp(name, email, password, phoneno) async {
  var response = await http.post(SIGNUP, body: {
    "name": name,
    "email": email,
    "password": password,
    "phoneno": phoneno,
  });
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('signuprsesponse', json.encode(user));
    return response.body;
  } else {
    return null;
  }
}

Future<String> submitEntries(
    compId, userId, imageUrl, videoUrl, message) async {
  var response = await http.post(SUBMITENTRY + compId + '/' + userId,
      body: {"message": message, "imageurl": imageUrl, "videourl": videoUrl});
  print(response.statusCode);
  print(response.body);
  return response.statusCode.toString();
}
