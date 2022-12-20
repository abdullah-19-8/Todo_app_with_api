// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_api/controller/todo_controller.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoController>(builder: (context, todoController, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Todo'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'title'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'description'),
              minLines: 1,
              maxLines: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => todoController
                  .submitData(
                context,
                titleController.text,
                descriptionController.text,
              )
                  .then((value) async {
                Navigator.pop(context);
                await todoController.fetchTodo();
              }),
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    });
  }
}
