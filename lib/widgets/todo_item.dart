import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/constants/color.dart';
import 'package:flutter_to_do_list/modal/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todoItem;
  final toggleDone;
  final deleteTodo;
  const ToDoItem(
      {super.key,
      required this.todoItem,
      required this.toggleDone,
      required this.deleteTodo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          toggleDone(todoItem);
        },
        title: Text(todoItem.todoText,
            style: TextStyle(
                fontSize: 20,
                color: textColor,
                decoration: todoItem.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: bgWhiteColor,
        leading: Icon(
          todoItem.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: secondaryColor,
        ),
        // subtitle: Text('Buy 2L of milk'),
        trailing: Container(
          width: 50,
          child: Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('delete');
                  deleteTodo(todoItem);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
