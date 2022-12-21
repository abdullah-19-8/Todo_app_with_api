import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_with_api/model/todo_model.dart';
import 'package:logger/logger.dart';

class TodoController with ChangeNotifier {
  TodoModel? _todoModel;
  TodoModel? get todoModel => _todoModel;

  final Logger _logger = Logger();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List _items = [];
  List get items => _items;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<TodoModel> fetchTodo() async {
    try {
      setLoading(true);
      final response = await http.get(
        Uri.parse(
          'https://api.nstack.in/v1/todos?page=1&limit=10',
        ),
      );
      TodoModel tempTodo = TodoModel.fromJson(jsonDecode(response.body));
      _todoModel = tempTodo;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['items'] as List;
        notifyListeners();
        _items = result;
      }
      setLoading(false);

      return tempTodo;
    } catch (e) {
      _logger.d(e);
      setLoading(false);
      rethrow;
    }
  }

  Future<void> deleteById(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'https://api.nstack.in/v1/todos/$id',
        ),
      );
      if (response.statusCode == 200) {
        final filtered =
            items.where((element) => element['_id'] != id).toList();
        _items = filtered;
        notifyListeners();
      }
    } catch (e) {
      _logger.d(e);
    }
  }

  Future<void> submitData(
      BuildContext context, String? title, String description) async {
    try {
      final body = {
        "title": title,
        "description": description,
        "is_completed": false,
      };
      await http.post(
        Uri.parse(
          "https://api.nstack.in/v1/todos",
        ),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      ).then((value) {
        if (value.statusCode == 201) {
          Fluttertoast.showToast(msg: 'success');
        } else {
          Fluttertoast.showToast(msg: 'failed');
        }
      });
    } catch (e) {
      _logger.d(e);
    }
  }

  Future<void> editData(BuildContext context, String id, String? title,
      String description) async {
    try {
      final body = {
        "title": title,
        "description": description,
        "is_completed": false,
      };
      await http.put(
        Uri.parse(
          "https://api.nstack.in/v1/todos/$id",
        ),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      ).then((value) {
        if (value.statusCode == 200) {
          Fluttertoast.showToast(msg: 'success');
        } else {
          Fluttertoast.showToast(msg: 'failed');
        }
      });
    } catch (e) {
      _logger.d(e);
    }
  }
}
