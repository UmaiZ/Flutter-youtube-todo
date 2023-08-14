import 'package:flutter/material.dart';
import 'package:flutter_todo_yt/helper/navigator.dart';
import 'package:flutter_todo_yt/helper/network.dart';
import 'package:flutter_todo_yt/src/model/todo_model.dart';
import 'package:flutter_todo_yt/src/view/todo_create.dart';
import 'package:flutter_todo_yt/src/view/todo_edit.dart';
import 'package:flutter_todo_yt/src/view/todo_list.dart';

class TodoViewModel extends ChangeNotifier {
  final NavigationService _navigationService;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  List<TodoModel> allTodos = [];

  TodoViewModel(this._navigationService) {
    getAllTodos();
  }

  navigateToCreate() {
    //BAD PRACTICE TO PASS CONTEXT IN VIEWMODEL LETS CREATE NAVIGATE SERVICE
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => const TodoCreate()));
    _navigationService.navigate(const TodoCreate());
  }

  navigateToEdit(TodoModel data) {
    titlecontroller.text = data.todoTitle.toString();
    descriptioncontroller.text = data.todoDescription.toString();

    _navigationService.navigate(TodoEdit(tododata: data));
  }

  getAllTodos() async {
    _navigationService.showLoader();
    var resData = await ApiProvider().get('/yt-todo-app');
    allTodos =
        resData.map<TodoModel>((item) => TodoModel.fromJson(item)).toList();
    print(allTodos);
    _navigationService.goBack();
    notifyListeners();
  }

  createTodo() async {
    _navigationService.showLoader();
    var resData = await ApiProvider().post('/yt-todo-app', {
      "todo_title": titlecontroller.text,
      "todo_description": descriptioncontroller.text
    });
    if (resData) {
      getAllTodos();
      _navigationService.goBack();
      _navigationService.navigate(const TodoList());
      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }

  editTodo(id) async {
    _navigationService.showLoader();
    var resData = await ApiProvider().put('/yt-todo-app/$id', {
      "todo_title": titlecontroller.text,
      "todo_description": descriptioncontroller.text
    });
    if (resData) {
      getAllTodos();
      _navigationService.goBack();
      _navigationService.navigate(const TodoList());
      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }

  deleteTodo(id, index) async {
    _navigationService.showLoader();
    var resData = await ApiProvider().delete("/yt-todo-app/$id");
    _navigationService.goBack();
    if (resData) {
      allTodos.removeAt(index);
      notifyListeners();
    } else {
      print('notDeleted');
    }
  }
}
