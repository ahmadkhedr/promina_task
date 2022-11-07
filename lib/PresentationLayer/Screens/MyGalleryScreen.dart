// ignore_for_file: prefer_const_constructors, avoid_returning_null_for_void, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_task/BusinessLogicLayer/cubit/upload_image_cubit.dart';
import 'package:pro_mina_task/Core/AppSingltons.dart';
import 'package:pro_mina_task/Core/Constants/ConstantsWidgets.dart';
import 'package:pro_mina_task/Core/Constants/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../BusinessLogicLayer/cubit/my_gallery_cubit.dart';
import '../../DataLayer/Models/OnLineModels/MyGalleryModel.dart';

class MyGalleryScreen extends StatelessWidget with ConstantWidgets {
  MyGalleryScreen({super.key});
  MyGalleryModel? myGalleryModel;

  @override
  Widget build(BuildContext context) {
    var myGalleryCubit =
        BlocProvider.of<MyGalleryCubit>(context, listen: false);
    var uploadImageCubit =
        BlocProvider.of<UploadImageCubit>(context, listen: false);
    myGalleryCubit.getUserGallery();
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/gallery_background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            BlocConsumer<MyGalleryCubit, MyGalleryState>(
              builder: (context, state) {
                if (state is MyGalleryIsLoading) {
                  return Container(
                    height: 100.h,
                    width: 100.w,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is MyGalleryLoaded) {
                  myGalleryModel = (state).myGalleryModel;
                  return Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            """Welcome""",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                        Text(
                          '${AppSingltons().userName}',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              signOutButton(context),
                              uploadButton(context, uploadImageCubit)
                            ],
                          ),
                        ),
                        gridViewImages(myGalleryModel!.data!.images),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
              listener: (context, state) => null,
            ),
            BlocListener<UploadImageCubit, UploadImageState>(
              listener: (context, state) {
                if (state is UploadImageLoading) {
                  showLoaderDialog(context, "Uploading Image");
                } else if (state is UploadImageInitial) {
                  Navigator.pop(context);
                } else if (state is UploadImageLoadded) {
                  Navigator.pop(context);
                  myGalleryCubit.getUserGallery();
                  Fluttertoast.showToast(msg: "Image Uploaded Succefully");
                } else if (state is UploadImageError) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Error Uploading image");
                }
              },
              child: SizedBox.shrink(),
            )
          ],
        ),
      ),
    ));
  }

  Widget gridViewImages(List<String>? images) {
    return GridView.builder(
        itemCount: images!.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
        itemBuilder: ((context, index) {
          return Column(
            children: [
              Container(
                  height: 12.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      // ignore: unnecessary_new
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      image: DecorationImage(
                          image: NetworkImage((images[index])),
                          fit: BoxFit.cover))),
              // Image(
              //   image: NetworkImage(images[index]),
              // ),
            ],
          );
        }));
  }

  Widget signOutButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final SharedPrefs = await SharedPreferences.getInstance();
        SharedPrefs.clear();
        Navigator.pushReplacementNamed(context, loginScreen);
      },
      child: Container(
        padding: EdgeInsets.all(1.h),
        height: 5.h,
        // width: 30.w,
        color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        child:
            // ignore: prefer_const_literals_to_create_immutables
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text("Log Out"),
          )
        ]),
      ),
    );
  }

  Widget uploadButton(BuildContext context, UploadImageCubit uploadImageCubit) {
    return InkWell(
      onTap: () {
        print("hi");
        showImageSource(context, uploadImageCubit);
      },
      child: Container(
        padding: EdgeInsets.all(1.h),
        height: 5.h,
        // width: 30.w,
        color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        child:
            // ignore: prefer_const_literals_to_create_immutables
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.arrow_upward,
            color: Colors.yellow,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text("Upload Image"),
          )
        ]),
      ),
    );
  }

  showImageSource(BuildContext context, UploadImageCubit uploadcubit) {
    final ImagePicker _picker = ImagePicker();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text("title"),
            backgroundColor: Color(0x80FFFFFF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            content: Container(
              height: 30.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  InkWell(
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                      uploadcubit.uploadImage(File(image!.path));
                    },
                    child: Image(
                      image: AssetImage("assets/images/gallery_source.png"),
                      height: 10.h,
                      width: 40.w,
                    
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: .5.h),
                    child: InkWell(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 50,
                        );
                        uploadcubit.uploadImage(File(image!.path));
                      },
                      child: Image(
                        image: AssetImage("assets/images/camera_source.png"),
                        height: 10.h,
                        width: 40.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    // AlertDialog alert = AlertDialog(
    //     content: Container(
    //   height: 30.h,
    //   width: 50.w,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20.0),
    //     color: Colors.red,
    //   ),
    //   child: Column(
    //     children: [
    //       Image(image: AssetImage("assets/images/gallery_source.png")),
    //       Image(image: AssetImage("assets/images/camera_source.png")),
    //     ],
    //   ),
    // ));
  }
}
