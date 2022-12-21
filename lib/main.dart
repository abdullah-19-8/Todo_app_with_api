// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_api/controller/todo_controller.dart';

import 'controller/theme_controller.dart';
import 'helper/colors.dart';
import 'view/todo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoController(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeController(),
        child:
            Consumer<ThemeController>(builder: (context, themeController, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.black),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black),
              ),
              indicatorColor: mySecondaryLightColor,
              primaryColor: myPrimaryColor,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: mySecondaryLightColor,
              ),
              splashColor: Theme.of(context).primaryColor.withOpacity(.05),
              highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
              brightness: Brightness.light,
              primarySwatch:
                  MaterialColor(myPrimaryColor.value, myPrimaryColorMap),
              appBarTheme: AppBarTheme(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Colors.black,
              ),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.grey),
              ),
              brightness: Brightness.dark,
              textTheme: const TextTheme(
                subtitle1: TextStyle(color: Colors.white),
              ),
              scaffoldBackgroundColor: const Color(0xFF000000),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF000000),
                foregroundColor: Colors.white,
              ),
            ),
            themeMode:
                themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const TodoListPage(),
          );
        }),
      ),
    );
  }
}
