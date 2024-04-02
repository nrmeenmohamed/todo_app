import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo_app/layout/cubit/cubit.dart';
import 'package:my_todo_app/layout/cubit/states.dart';
import 'package:my_todo_app/modules/add_screen.dart';
import 'package:my_todo_app/shared/components/components.dart';
import 'package:my_todo_app/shared/network/local/cache_helper.dart';
import 'package:my_todo_app/shared/styles/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../modules/login_screen.dart';

class HomeScreen extends StatelessWidget {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {

        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
        key: scaffoldKey,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
            titleSpacing: 20,
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
                  onPressed: (){
                    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
                      scaffoldKey.currentState?.closeDrawer();
                    } else {
                      scaffoldKey.currentState?.openDrawer();
                    }
                  },
                  icon: Icon(
                    Icons.person,
                    color: const Color(0xFF300103),
                    size: 35.sp,
                  ),
                ),
            actions:[
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 20),
                child: Image(
                image: const AssetImage("assets/images/logo.png"),
                width: 120.w,
            ),
              ),
            ],
          ),

          drawer: Drawer(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(60.r),
              ),
            ),
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text(
                      '${CacheHelper.getData(key: 'username')}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    accountEmail: const Text(
                      'example@gmail.com',
                    ),
                  currentAccountPicture: CircleAvatar(
                    radius: 20.r,
                    child: const ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/face.jpg'),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        AppColor.firstColor,
                        AppColor.thirdColor,
                        AppColor.secondColor,
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    size: 25.sp,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  onTap: (){
                    CacheHelper.deleteData(key: 'username');
                    debugPrint('username = ${CacheHelper.getData(key: 'username')} *******');
                    navigateTo(context, LoginScreen());
                  },
                ),
              ],
            ),
          ),

          bottomNavigationBar: StylishBottomBar(
            option: AnimatedBarOptions(
              iconSize: 32,
              barAnimation: BarAnimation.blink,
              iconStyle: IconStyle.animated,
              opacity: 0.8,
            ),
            items:cubit.bottomItem,
            hasNotch: true,
            currentIndex: cubit.currentIndex,
            fabLocation: StylishBarFabLocation.end,
            onTap: (index){
              cubit.changeBottomBar(index);
            },
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddScreen().animate().slideY());
            },
            backgroundColor: AppColor.firstColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
