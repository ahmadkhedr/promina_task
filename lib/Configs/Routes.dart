// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina_task/Core/Constants/Strings.dart';

import '../BusinessLogicLayer/cubit/login_cubit.dart';
import '../BusinessLogicLayer/cubit/my_gallery_cubit.dart';
import '../BusinessLogicLayer/cubit/upload_image_cubit.dart';
import '../PresentationLayer/Screens/LoginScreen.dart';
import '../PresentationLayer/Screens/MyGalleryScreen.dart';

class AppRoutes {
  Route? onGenarateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
        );

      case myGalleryScreen:
        return MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(providers: [
                  BlocProvider<UploadImageCubit>(
                      create: (BuildContext context) => UploadImageCubit()),
                  BlocProvider<MyGalleryCubit>(
                      create: (BuildContext context) => MyGalleryCubit())
                ], child: MyGalleryScreen())));
    }
  }
}
