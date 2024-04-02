import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/layout/cubit/cubit.dart';
import 'package:my_todo_app/layout/cubit/states.dart';
import 'package:my_todo_app/layout/home_screen.dart';
import 'package:my_todo_app/shared/network/local/cache_helper.dart';
import 'package:my_todo_app/shared/styles/colors.dart';

import '../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Image(
                          image: AssetImage('assets/images/login.png'),

                      ),
                      Text(
                        'TaskEase',
                        style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.firstColor,
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Text(
                        'Create, organize, and edit your tasks',
                        style: TextStyle(
                              fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      TextField(
                        onSubmitted: (value){
                          CacheHelper.saveDate(key: 'username', value: value);
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Username',
                          prefixIcon: Icon(
                              Icons.edit,
                            color: AppColor.firstColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      TextField(
                        obscureText: cubit.isPasswordShow,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColor.firstColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: (){
                              cubit.changePasswordShown();
                            },
                            icon:cubit.isPasswordShow ? Icon(
                              Icons.visibility_off,
                              color: AppColor.firstColor,
                            ) : Icon(
                              Icons.visibility,
                              color: AppColor.firstColor,
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                            onPressed: (){
                              navigateAndFinish(context, HomeScreen());
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.firstColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17.sp,
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

