import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/provider/todos.dart';
import 'package:flutter_todo_provider/widget/todo_widget.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? const Center(
            child: Text(
            'Aucune note ajoutée',
            style: TextStyle(fontSize: 20),
          ))
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              height: 20,
            ),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
          );
  }
}
