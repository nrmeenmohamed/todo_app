import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components/components.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppDeleteDatabaseState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Task Deleted',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),
              // Color(0xFF300103)
              backgroundColor: Colors.redAccent,
              dismissDirection: DismissDirection.up,
              duration: Duration(milliseconds: 800),
            ),
          );
        }
      },
      builder: (BuildContext context, AppStates state) {

        var doneTasks = AppCubit.get(context).doneTask;

        return doneTaskBuilder(tasks: doneTasks);
      },
    );
  }
}
