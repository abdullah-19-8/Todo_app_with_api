// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_api/controller/todo_controller.dart';

class EditTaskPage extends StatefulWidget {
  final String? title;
  final String? description;
  final String? id;
  const EditTaskPage({
    Key? key,
    this.title,
    this.description,
    this.id,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title!;
    descriptionController.text = widget.description!;
    super.initState();
  }

  @override
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
              onPressed: () {
                todoController
                    .editData(
                  context,
                  widget.id!,
                  titleController.text,
                  descriptionController.text,
                )
                    .then((value) async {
                  Navigator.pop(context);
                  await todoController.fetchTodo();
                });
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    });
  }
}
