import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_task/DataLayer/WebServices/UploadImageWebService.dart';

class UploadImageRepository {
  final uploadImageWebService = UploadImageWebService();
  Future<int> uploadImageRequest(File image) async {
    var reponse = await uploadImageWebService.uploadImageRequest(image);
    

    return reponse;
  }
}
