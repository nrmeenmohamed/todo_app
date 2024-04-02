import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo_app/layout/cubit/cubit.dart';
import 'package:my_todo_app/layout/cubit/states.dart';
import 'package:my_todo_app/modules/login_screen.dart';
import 'package:my_todo_app/shared/network/local/cache_helper.dart';
import 'modules/welcome_screen.dart';
import 'layout/cubit/cubit_observer.dart';
import 'layout/home_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget widget;

  bool? boarding = CacheHelper.getData(key: 'onBoarding');
  String? username = CacheHelper.getData(key: 'username');

  if(boarding != null){
    if(username != null) {
      widget = HomeScreen();
    } else {
      widget = const LoginScreen();
    }
  }
  else{
    widget = const WelcomeScreen();
  }

  debugPrint('onBoarding = $boarding\nusername = $username');

  runApp(MyAPP(startWidget: widget,));


}

class MyAPP extends StatelessWidget {

 final Widget startWidget;

 const MyAPP({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {  },
          builder: (BuildContext context, AppStates state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home:startWidget,
            );
          },
        ),
      ),
    );
  }
}




