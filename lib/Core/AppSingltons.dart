class AppSingltons {
  static final AppSingltons _singleton = AppSingltons._internal();
  AppSingltons._privateConstructor();
  static final AppSingltons _instance = AppSingltons._privateConstructor();
  static AppSingltons get instance => _instance;

  factory AppSingltons() {
    return _singleton;
  }

  AppSingltons._internal();
  String? token = "";
  int userId = 0;
  String userName = "";
}
