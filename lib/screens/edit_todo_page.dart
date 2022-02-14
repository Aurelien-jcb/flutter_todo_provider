import 'package:flutter_todo_provider/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/provider/todos.dart';
import 'package:flutter_todo_provider/widget/todo_form_widget.dart';
import 'package:provider/provider.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);
  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Modifier une tache'),
        actions: [
          IconButton(
            onPressed: () {
              final provider = Provider.of<TodosProvider>(context);
              provider.removeTodo(widget.todo);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() {
              this.title = title;
            }),
            onChangedDescription: (description) => setState(() {
              this.description = description;
            }),
            onSavedTodo: saveTodo,
          ),
        ),
      ));

  void saveTodo() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    } else {
      return;
    }
  }
}
