import 'package:flutter/material.dart';

class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Buy Milk',
        isDone: true,
      ),
      ToDo(
        id: '02',
        todoText: 'Buy Eggs',
        isDone: false,
      ),
      ToDo(
        id: '03',
        todoText: 'Buy Bread',
        isDone: false,
      ),
    ];
  }

  // static void addTodo (String todoText){
  //   todoList.add(ToDo(
  //     id: DateTime.now().toString(),
  //     todoText: todoText,
  //     isDone: false
  //   ));
  // }

  // static void deleteTodo (String id){
  //   todoList.removeWhere((element) => element.id == id);
  // }

  // static void toggleDone (String id){
  //   final todo = todoList.firstWhere((element) => element.id == id);
  //   todo.isDone = !todo.isDone;
  // }
}
