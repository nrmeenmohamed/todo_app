import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/layout/cubit/states.dart';
import 'package:my_todo_app/models/dataBase/sqlit.dart';
import 'package:my_todo_app/modules/tasks_screen.dart';
import 'package:my_todo_app/shared/styles/colors.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';

import '../../modules/done_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) =>BlocProvider.of(context);

  // hide & show password
  bool isPasswordShow = false;

  void changePasswordShown(){
    isPasswordShow = ! isPasswordShow;
    emit(AppShowPasswordState());
  }

  // bottom navigation bar section
  List<BottomBarItem> bottomItem = [
    BottomBarItem(
      unSelectedColor: Colors.black54,
      icon: const Icon(
        Icons.list_alt_outlined,
      ),
      title: const Text(
        'Tasks'
      ),
      selectedColor: AppColor.thirdColor,
    ),
    BottomBarItem(
      unSelectedColor: Colors.black54,
      icon: const Icon(
        Icons.check_circle_outline_outlined,
      ),
      title: const Text(
          'Done'
      ),
      selectedColor: AppColor.secondColor,
    ),
  ];

  List<Widget> screens = [
    const TasksScreen(),
    const DoneScreen(),
  ];

  int currentIndex = 0;

  void changeBottomBar(int index){
    currentIndex = index;
    emit(AppBottomBarState());
  }

  int checkBoxStatus = 0;

///////
  SqlDb? database = SqlDb();

  void createDatabase() async {
    await database!.db;
    emit(AppCreateDatabaseState());
    getTask();
  }

  insertTask({
    required String title,
    required String description,
    required String category,
    int? done,
  }) async {
    int response = await database!.insertData('''
      INSERT INTO tasks(title, description, category, done) VALUES
      ("$title", "$description", "$category", $done)
      ''');
    emit(AppInsertDatabaseState());
    getTask();
    debugPrint('inserted raw number = $response');
  }

  List<Map> newTask = [];
  List<Map> doneTask = [];

  getTask() async {
    newTask.clear();
    doneTask.clear();
    emit(AppGetDatabaseLoadingState());
    (await database!.readData("SELECT * FROM tasks")).forEach((element) {
      if (element['done'] == 0) {
        newTask.add(element);
      } else if (element['done'] == 1) {
        doneTask.add(element);
      }
    });
    emit(AppGetDatabaseState());
    debugPrint('newTask is $newTask');
    debugPrint('doneTask is $doneTask');
  }

  updateTask({
    String? title,
    String? description,
    String? category,
    int? done,
    required int id,
  }) async {
    await database!.updateData(
      'UPDATE tasks SET title = ?, description = ?, category = ?, done = ? WHERE id = ?',
      ['$title', '$description', '$category', done!, id],
    );
    emit(AppUpdateDatabaseState());
    getTask();
  }

  deleteTask({
    required int id,
  }) async {
    await database!.deleteData('DELETE FROM tasks WHERE id = ?', [id]);
    emit(AppDeleteDatabaseState());
    getTask();
  }
}