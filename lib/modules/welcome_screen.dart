import'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/shared/network/local/cache_helper.dart';
import 'package:my_todo_app/shared/styles/colors.dart';
import '../shared/components/components.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/images/welcome.jpg'),
              ),
              SizedBox(height: 20.h,),

              Text(
                'Boost Your Productivity',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
              SizedBox(height: 20.h,),

              Text(
                'With TaskEase, You can effortlessly create,organize and edit your tasks, helping you stay focused and achieve your goals.',
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                     height: 1.5.h,
                     //fontWeight: FontWeight.w600,
                    )
                ),
              ),
              SizedBox(height: 40.h,),

              Center(
                child: ElevatedButton(
                  onPressed: (){
                    CacheHelper.saveDate(key: 'onBoarding', value: true).then((value){
                      if(value){
                        navigateAndFinish(context, const LoginScreen());
                      }
                      debugPrint('onboarding = $value ***************************');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.thirdColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Start',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                        SizedBox(width: 15.w,),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ],
                    ),
                ),
              ),
            ].
            animate().slideX(curve: Curves.slowMiddle,duration: const Duration(milliseconds: 900)),
          ),
        ),
      ),
    );
  }
}
