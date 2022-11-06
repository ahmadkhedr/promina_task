import 'package:pro_mina_task/DataLayer/WebServices/MyGalleryWebService.dart';

import '../Models/OnLineModels/MyGalleryModel.dart';

class MyGalleryRepository {
  final myGalleryWebService = MyGalleryWebService();

  Future<MyGalleryModel> getUserGallery() async {
    var item = await myGalleryWebService.getUserGallery();

    return item;
  }
}
