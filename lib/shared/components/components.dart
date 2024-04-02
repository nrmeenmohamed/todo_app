import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../layout/cubit/cubit.dart';
import '../../modules/edit_screen.dart';
import 'constant.dart';

void navigateTo(context, widget) => Navigator.push(context,
  MaterialPageRoute(
    builder:(context) => widget ,
  ),
);


void navigateAndFinish(context, widget) => Navigator.pushReplacement(context,
  MaterialPageRoute(
    builder:(context) => widget ,
  ),
);


Widget fieldForm({
  double? height,
  String? initialValue,
  required Function onChanged,
  bool expanded = false,
  TextInputType keyboardType = TextInputType.text,
}) => Material(
  borderRadius: BorderRadius.circular(10.r),
  elevation: 10.0,
  child: Container(
    height: height?.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white
    ),
    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
    child: FastTextField(
      expands: expanded,
      maxLines: null,
      minLines: null,
     onChanged: (value){onChanged(value);},
      initialValue: initialValue,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'must not be empty';
        }
        else{
          return null;
        }
      },
      keyboardType: keyboardType,
      name: 'form',
      cursorColor:const Color(0xFFBF5349) ,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    ),
  ),
);



Widget dropDown (context,{
  required Function onChanged,
  String? initialValue,
}) => Material(
  elevation: 10.0,
  borderRadius: BorderRadius.circular(10.r),
  child: Container(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
    width: MediaQuery.of(context).size.width/3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: Colors.white,
    ),
    child: FastDropdown(
      name: 'dropdown',
      initialValue: initialValue,
      onChanged: (value){onChanged(value);},
      validator: (value){
        if(value == null || value.isEmpty){
          return 'must not be empty';
        }
        else{
          return null;
        }
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      items: category,
    ),
  ),
);


Widget button({
  required Function onPressed,
  required String text,
  required Color backgroundColor,
}) => Align(
  alignment: AlignmentDirectional.bottomEnd,
  child: ElevatedButton(
    onPressed: (){onPressed();},
    style: ElevatedButton.styleFrom(
      backgroundColor:backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    child: Text(
      text,
    ),
  ),
);


Widget taskContainer(context,{
  required Map modelDb,
  Color? color,
}) => Padding(
  padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
  child:   Dismissible(
    key: Key(modelDb['id'].toString()),
    onDismissed: (direction){
      AppCubit.get(context).deleteTask(id: modelDb['id']);
      debugPrint('it is deleted ****************');
    },
    child: GestureDetector(
      onTap: (){
        navigateTo(context, EditScreen(
          titleController: modelDb['title'],
          descriptionController: modelDb['description'],
          categoryController: modelDb['category'],
          id: modelDb['id'],
        ));
      },
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: const EdgeInsetsDirectional.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${modelDb['category']}',
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
              FastCheckbox(
                name: 'task container',
                onSaved: (value){},
                onChanged: (value){
                  final Map modifiedModelDb = {...modelDb}; // Make a copy
                  if (value != null && value) {
                    AppCubit.get(context).checkBoxStatus = 1;
                    modifiedModelDb['done'] = 1; // Modify the copy
                  } else {
                    AppCubit.get(context).checkBoxStatus = 0;
                    modifiedModelDb['done'] = 0; // Modify the copy
                  }
                  AppCubit.get(context).updateTask(
                    id: modelDb['id'],
                    done: AppCubit.get(context).checkBoxStatus,
                    title: modelDb['title'],
                    description: modelDb['description'],
                    category: modelDb['category'],
                  );
                  AppCubit.get(context).checkBoxStatus = 0;
                  debugPrint('Value changed');
                  // Now you can use modifiedModelDb instead of modelDb
                  debugPrint('value change----------------------');
                  // AppCubit.get(context).getTask(database);
                },
                titleBuilder: (context) =>Text(
                  '${modelDb['title']}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '${modelDb['description']}',
                  style: TextStyle(
                      color: Colors.grey[300]
                  ),
                ),
                activeColor: Colors.white,
                checkColor: Colors.black,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);


Widget doneTaskContainer(context,{
  required Map modelDb,
  Color? color,
}) => Padding(
  padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
  child:   Dismissible(
    key: Key(modelDb['id'].toString()),
    onDismissed: (direction){
      // AppCubit.get(context).deleteData(id: model['id']
      AppCubit.get(context).deleteTask(id: modelDb['id']);
      debugPrint('it is deleted*********');
    },
    child: Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: const EdgeInsetsDirectional.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          // color attr
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${modelDb['category']}',
              style: const TextStyle(
                color: Colors.white,

              ),
            ),
            ListTile(
              title: Text(
                '${modelDb['title']}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black54,
                  decorationStyle: TextDecorationStyle.double,
                ),
              ),
              subtitle: Text(
                '${modelDb['description']}',
                style: TextStyle(
                    color: Colors.grey[300]
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);


Widget taskBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: tasks.length,

      itemBuilder: (context, index) => taskContainer(context, modelDb: tasks[index], color: colors[index % colors.length]),

      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.h,),

    );
  },
  fallback: (BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list,
            size: 100,
            color: Colors.black54,
          ),
          Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  },
);


Widget doneTaskBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (BuildContext context) {
    return ListView.separated(

      itemCount: tasks.length,

      itemBuilder: (context, index) => doneTaskContainer(context, modelDb: tasks[index], color: colors[index % colors.length]),

      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.h,),

    );
  },
  fallback: (BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list,
            size: 100,
            color: Colors.black54,
          ),
          Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  },

);