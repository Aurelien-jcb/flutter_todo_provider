import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/provider/todos.dart';
import 'package:flutter_todo_provider/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = 'TodoList Application';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(242, 145, 0, 10),
          secondary: Color.fromARGB(246, 63, 63, 63),
        )),
        home: const HomePage(),
      ),
    );
  }
}
