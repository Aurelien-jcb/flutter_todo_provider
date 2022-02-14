import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_provider/model/todo.dart';
import 'package:flutter_todo_provider/provider/todos.dart';
import 'package:flutter_todo_provider/screens/edit_todo_page.dart';
import 'package:flutter_todo_provider/utils/utils.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({required this.todo, Key? key}) : super(key: key);
  final Todo todo;
  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        key: Key(todo.id),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              label: 'Modifier',
              backgroundColor: Colors.green,
              icon: Icons.edit,
              onPressed: (context) {
                editTodo(context, todo);
              },
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              label: 'Supprimer',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (context) {
                deleteTodo(context, todo);
              },
            ),
          ],
        ),
        child: buildTodo(context),
      ));

  Widget buildTodo(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              checkColor: Colors.white,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
                Utils.showSnackBar(
                  context,
                  isDone ? 'Note archivée' : 'Note restaurée',
                );
              },
              value: todo.isDone,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22),
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: const TextStyle(fontSize: 20, height: 1.5),
                    ),
                  )
              ],
            ))
          ],
        ),
      );

  deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Note supprimée');
  }

  editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
