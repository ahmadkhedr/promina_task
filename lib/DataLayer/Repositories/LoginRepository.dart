import 'package:pro_mina_task/DataLayer/WebServices/LoginWebService.dart';

import '../Models/OnLineModels/LoginModel.dart';

class LoginRepository {
  final loginWebService = LoginWebService();

  Future<LoginModel> userLoginRequest(String userMail, String userPass) async {
    var loginReponse =
        await loginWebService.userLoginRequest(userMail, userPass);

    return loginReponse;
  }
}
