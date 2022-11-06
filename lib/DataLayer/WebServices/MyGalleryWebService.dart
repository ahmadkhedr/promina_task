import 'package:http/http.dart' as http;
import 'package:pro_mina_task/Core/AppSingltons.dart';
import 'package:pro_mina_task/DataLayer/Models/OnLineModels/MyGalleryModel.dart';

import '../../Core/Constants/Strings.dart';

class MyGalleryWebService {
  Future<MyGalleryModel> getUserGallery() async {
    var response = await http.get(Uri.parse("$baseUrl/my-gallery"), headers: {
      "Authorization": "Bearer ${AppSingltons().token}",
    });
    return myGalleryModelFromJson(response.body);
  }
}
