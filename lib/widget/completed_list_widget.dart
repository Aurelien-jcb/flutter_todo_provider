import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/provider/todos.dart';
import 'package:flutter_todo_provider/widget/todo_widget.dart';
import 'package:provider/provider.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(
            child: Text(
            'Aucune note archivée',
            style: TextStyle(fontSize: 20),
          ))
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
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
