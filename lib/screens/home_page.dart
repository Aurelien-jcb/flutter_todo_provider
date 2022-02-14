import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/main.dart';
import 'package:flutter_todo_provider/widget/add_todo_dialog.dart';
import 'package:flutter_todo_provider/widget/completed_list_widget.dart';
import 'package:flutter_todo_provider/widget/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [const TodoListWidget(), const CompletedListWidget()];

    return Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
            selectedIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              label: "Note",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 20,
              ),
              label: "Notes terminés",
            ),
          ],
        ),
        body: tabs[selectedIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddTodoDialog(),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ));
  }
}
