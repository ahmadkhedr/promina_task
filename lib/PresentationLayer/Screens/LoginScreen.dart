// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pro_mina_task/Core/Constants/ConstantsWidgets.dart';
import 'package:pro_mina_task/Core/Constants/Strings.dart';
import 'package:sizer/sizer.dart';

import '../../BusinessLogicLayer/cubit/login_cubit.dart';
import '../../Core/AppSingltons.dart';
import '../../DataLayer/Models/OnLineModels/LoginModel.dart';

class LoginScreen extends StatelessWidget with ConstantWidgets {
  LoginModel? loginModel;
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loginBloc = BlocProvider.of<LoginCubit>(context, listen: false);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_background.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Text(
                "My Gellary",
                style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 30.sp),
              ),
            ),
            BlocListener<LoginCubit, LoginState>(
              listener: ((context, state) {
                if (state is LoginFailed) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "error Occured");
                } else if (state is LoginLoading) {
                  showLoaderDialog(context);
                } else if (state is LoginLoaded) {
                  loginModel = (state).loginModel;
                  AppSingltons().token = loginModel!.token!;
                  AppSingltons().userName = loginModel!.user!.name!;
                  AppSingltons().userId = loginModel!.user!.id!;

                  Navigator.pop(context);
                  Navigator.pushNamed(context, myGalleryScreen);
                }
              }),
              child: Container(
                padding: EdgeInsets.all(4.h),
                width: 70.w,
                decoration: BoxDecoration(
                    color: Color(0x66FFFFFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                child: Column(children: [
                  emailTextField(loginBloc),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h, bottom: 0.h),
                    child: passWordTestField(loginBloc),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: submitButton(loginBloc),
            )
          ],
        ),
      ),
    ));
  }

  Widget emailTextField(LoginCubit bloc) {
    return StreamBuilder(
      stream: bloc.mailStream,
      builder: ((BuildContext context, snapshot) {
        return SizedBox(
          width: 65.w,
          //height: 8.h,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                // isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                alignLabelWithHint: true,
                hintText: 'User Name',
                // label: Text("Your Password"),

                //  contentPadding: EdgeInsets.all(10.0),
                suffix: const Icon(
                  Icons.mail,
                  color: Colors.blue,
                ),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.blue),
                // ),
                errorText:
                    snapshot.hasError ? snapshot.error.toString() : null),
            onChanged: (String input) {
              bloc.emailChanged(input);
            },
          ),
        );
      }),
    );
  }

  Widget passWordTestField(LoginCubit bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: ((context, snapshot) {
        return SizedBox(
          width: 80.w,
          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                // isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                alignLabelWithHint: true,
                hintText: 'Password',
                // label: Text("Your Password"),

                //  contentPadding: EdgeInsets.all(10.0),
                suffix: const Icon(
                  Icons.password,
                  color: Colors.blue,
                ),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.blue),
                // ),
                errorText:
                    snapshot.hasError ? snapshot.error.toString() : null),
            onChanged: bloc.passwordChanged,
          ),
        );
      }),
    );
  }

  Widget submitButton(LoginCubit bloc) {
    return StreamBuilder(
        stream: bloc.activateButton,
        builder: ((context, snapshot) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: snapshot.hasError || !snapshot.hasData
                ? null
                : (() {
                    FocusScope.of(context).requestFocus(FocusNode());
                    bloc.startLoginRequest();
                  }),
            child: Text("          Submit             "),
          );
        }));
  }
}
