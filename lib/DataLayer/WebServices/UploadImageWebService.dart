// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_task/Core/Constants/Strings.dart';
import 'package:http_parser/http_parser.dart' as parser;

import '../../Core/AppSingltons.dart';

class UploadImageWebService {
  // Future uploadImageRequest(File image) async {
  //   // var reponse = await http.post(Uri.parse("$baseUrl/upload"), headers: {
  //   //   "Authorization": "Bearer ${AppSingltons().token}",
  //   //   // "Content-Type": "application/json",
  //   //   // "Accept": "application/json"
  //   // }, body: {
  //   //   "img": image
  //   // });
  //   Map<String,String> headers={
  //     "Authorization":"Bearer ${AppSingltons().token}",
  //     "Content-type": "multipart/form-data"
  //   };
  //   var request =
  //       new http.MultipartRequest("POST", Uri.parse("$baseUrl/upload"));
  //   request.files.add(new http.MultipartFile.fromBytes(
  //       "file", image.readAsBytesSync(),
  //       filename: "Photo.jpg", contentType: parser.MediaType("image", "jpg")));

  //   var response = await request.send();
  //   print(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  Future<int> uploadImageRequest(File image)async{
    ///MultiPart request
    var request = http.MultipartRequest(
        'POST', Uri.parse("$baseUrl/upload"),

    );
    Map<String,String> headers={
      "Authorization":"Bearer ${AppSingltons().token}",
     // "Content-type": "multipart/form-data"
    };
    request.files.add(
        http.MultipartFile(
           'img',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: "filename",
          contentType: parser.MediaType('image','jpg'),
        ),
    );
    request.headers.addAll(headers);
    
    print("request: "+request.toString());
    var res = await request.send();
    print("This is response: ${res.statusCode}");
    return res.statusCode;
  }
}

