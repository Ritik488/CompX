import 'dart:convert';

import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Models/MainUser.dart';
import 'package:huncha/Models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<String> loginhttp(url, email, password) async {
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
  }
  return response.body;
}

Future<String> signupHttp(name, email, password,phoneno, uclass) async {
  var response =
      await http.post(SIGNUP, 
      body: {
        "name":name,
        "email": email,
        "password": password,
        "phoneno": phoneno,
        "Uclass": uclass
      });
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('signuprsesponse', json.encode(user));
    return response.body;
  }else{
    return null;
  }
  
}