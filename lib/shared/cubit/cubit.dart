import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/modules/todo_app/archive_tasks/archive_tasks_screen.dart';
import 'package:untitled/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:untitled/modules/todo_app/new_tasks/new_tasks_screen.dart';

import 'package:untitled/shared/cubit/states.dart';

import 'package:untitled/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex=0;
  List<Widget> screens =
  [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchiveTaskScreen(),
  ];

  List<String> titles=
  [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];


void changeIndex (int index){
  currentIndex=index;
  emit(AppChangeBottomNavBarState());
}
  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];

  void createDatabase()
  {
    openDatabase(
      'todo.db',

      version: 1,
      onCreate: (database, version)
      {
        print('database created');

        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT, date TEXT , time TEXT ,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error)
        {
          print('Error when create table ${error.toString()}');
        });

      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database is opened');

      },

    ).then((value) {
      database =value;
      emit(AppCreateDatabaseState());
    });


  }
  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
    await database.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks(title, date,time,status) VALUES("$title","$date","$time","new")').
      then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);

      }).catchError((error) {
        print('error when inserting data ${error.toString()}');
      });

      return Future(() => null);




    });


  }

  void getDataFromDatabase(database) {
    newTasks =[];
    doneTasks=[];
    archiveTasks=[];

    emit(AppLoadingDatabaseState());
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element) {
        print(element['status']);
        if (element['status'] == 'new'){
          newTasks.add(element);
        }else if(element['status'] == 'done'){
          doneTasks.add(element);
        }else{
          archiveTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateDatabase({
    required String status,
    required int id,
}) async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
    });

  }

  void deleteDatabase({
    required int id,
  }) async
  {
    database.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }


  bool isBottomSheet=false;
  IconData fabIcon=Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
})
  {
    isBottomSheet = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
}

  bool isDark=false;

  void changeMode({bool? fromShared}){
    if(fromShared != null)
    {
      isDark=fromShared!;
      emit(NewsChangeModeState());
    }else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', isDark: isDark).then(
              (value) {
            emit(NewsChangeModeState());
          });
    }
  }




}