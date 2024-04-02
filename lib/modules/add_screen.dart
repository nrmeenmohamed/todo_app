import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo_app/layout/cubit/cubit.dart';
import 'package:my_todo_app/layout/cubit/states.dart';
import 'package:my_todo_app/shared/components/components.dart';
import 'package:my_todo_app/shared/styles/colors.dart';


class AddScreen extends StatelessWidget {

  AddScreen({super.key});

 var formKey = GlobalKey<FormState>();

 var titleController;

 var descriptionController;

 var categoryController;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: AppColor.firstColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Image(
              image: const AssetImage("assets/images/logo.png"),
              width: 120.w,
              height: 50.h,
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),

          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsetsDirectional.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: formKey,
                            child: FastFormSection(
                              header: Text(
                                'Add New Task',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFBF5349).withOpacity(0.9),
                                ),
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 25.h,),
                                    Text(
                                      'title',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),

                                    // important title
                                    fieldForm(
                                      onChanged: (value){
                                        titleController = value;
                                        debugPrint('titleController ***** $titleController *****');
                                      },

                                    ),


                                    SizedBox(height: 15.h,),
                                    Text(
                                      'description',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),


                                    // important description
                                    fieldForm(
                                      expanded: true,
                                        keyboardType: TextInputType.multiline,
                                        height: 100.h,
                                        onChanged: (value){
                                          descriptionController = value;
                                          debugPrint('descriptionController ***** $descriptionController *****');
                                        },
                                    ),




                                    SizedBox(height: 15.h,),
                                    Text(
                                      'category',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),



                                    // drop
                                    dropDown(
                                      context,
                                      onChanged: (value){
                                        categoryController = value;
                                        debugPrint(categoryController);
                                      },
                                    ),
                                    SizedBox(height: 15.h,),




                                    // add
                                    button(
                                      onPressed: (){
                                        if(formKey.currentState != null && formKey.currentState!.validate()){
                                          cubit.insertTask(
                                              title: titleController.toString(),
                                              description: descriptionController.toString(),
                                              category: categoryController.toString(),
                                            done: cubit.checkBoxStatus,
                                          );

                                          debugPrint('title is $titleController******');
                                          debugPrint('desc is $descriptionController********');
                                          debugPrint('category is $categoryController*******');
                                          Navigator.pop(context);
                                        }
                                        else{
                                          debugPrint('can not navigate');
                                        }
                                      },
                                      text: 'add',
                                      backgroundColor: AppColor.firstColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

