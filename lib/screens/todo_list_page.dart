// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../controller/todo_controller.dart';
import 'add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoController>(context, listen: false).fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo List'),
      ),
      body: Consumer<TodoController>(builder: (context, todoController, _) {
        return Visibility(
          visible: todoController.isLoading,
          replacement: RefreshIndicator(
            onRefresh: todoController.fetchTodo,
            child: ListView.builder(
              itemCount: todoController.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(
                    todoController.items[index]['title'],
                  ),
                  subtitle: Text(
                    todoController.items[index]['description'],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 'edit') {
                        // go to edit page
                      } else if (value == 'delete') {
                        //delete and remove task
                        todoController.deleteById(
                          todoController.items[index]['_id'],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoPage(),
            ),
          );
        },
        label: const Text('Add Todo'),
      ),
    );
  }
}
