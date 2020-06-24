import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huncha/Models/MainUser.dart';
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
    pref.setString('Userresponse', json.encode(user));
  }
  return response.body;
}