import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro_mina_task/Core/Constants/Strings.dart';
import 'package:pro_mina_task/DataLayer/Models/OnLineModels/LoginModel.dart';

class LoginWebService {
  Future<LoginModel> userLoginRequest(String userMail, String userPass) async {
    var response = await http.post(Uri.parse("$baseUrl/auth/login"),
        body: {"email": "$userMail", "password": "$userPass"});
   // debugPrint(response.body);
    return loginModelFromJson(response.body);
  }
}
