// ignore_for_file: prefer_const_constructors, avoid_returning_null_for_void

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../BusinessLogicLayer/cubit/my_gallery_cubit.dart';
import '../../DataLayer/Models/OnLineModels/MyGalleryModel.dart';

class MyGalleryScreen extends StatelessWidget {
  MyGalleryScreen({super.key});
  MyGalleryModel? myGalleryModel;

  @override
  Widget build(BuildContext context) {
    var myGalleryCubit =
        BlocProvider.of<MyGalleryCubit>(context, listen: false);
    myGalleryCubit.getUserGallery();
    return Scaffold(
        body: Center(
      child: BlocConsumer<MyGalleryCubit, MyGalleryState>(
        builder: (context, state) {
          if (state is MyGalleryIsLoading) {
            return Container(
              height: 100.h,
              width: 100.w,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is MyGalleryLoaded) {
            myGalleryModel = (state).myGalleryModel;
            return Text(myGalleryModel!.status!);
          } else {
            return SizedBox.shrink();
          }
        },
        listener: (context, state) => null,
      ),
    ));
  }
}
