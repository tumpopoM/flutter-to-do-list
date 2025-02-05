import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/constants/color.dart';
import 'package:flutter_to_do_list/modal/todo.dart';
import 'package:flutter_to_do_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final TextEditingController _todoController = TextEditingController();
  List<ToDo> _foundTodoList = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundTodoList = todoList;
    super.initState();
  }

  void searchTodoList(String searchKey) {
    print('Search Key ::::: ${searchKey}');
    if (searchKey.isEmpty) {
      setState(() {
        _foundTodoList = todoList;
      });
    } else {
      final List<ToDo> _searchList = todoList
          .where((element) =>
              element.todoText.toLowerCase().contains(searchKey.toLowerCase()))
          .toList();
      setState(() {
        _foundTodoList = _searchList;
      });
    }
  }

  void addTodo(String todoText) {
    print('Add Todo ::::: ${todoText}');
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: todoText,
        isDone: false,
      ));
    });
    _todoController.clear();
  }

  void deleteTodo(ToDo todoItem) {
    setState(() {
      todoList.removeWhere((element) => element.id == todoItem.id);
    });
  }

  void toggleDone(ToDo todoItem) {
    setState(() {
      final todo = todoList.firstWhere((element) => element.id == todoItem.id);
      todo.isDone = !todo.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              SearchBox(searchTodoList: searchTodoList),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'All ToDos',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (var todo in _foundTodoList)
                      ToDoItem(
                        todoItem: todo,
                        toggleDone: toggleDone,
                        deleteTodo: deleteTodo,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: bgWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add ToDo',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Add Todo !!!! ${_todoController.text}');
                    addTodo(_todoController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.add,
                      color: bgWhiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.check_box_outlined,
            color: textColor,
            size: 30,
          ),
          const Text('To Do List'),
          Container(
            color: bgColor,
            width: 40,
            height: 40,
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Align(
                alignment: Alignment.topCenter, // กำหนดให้ภาพอยู่ด้านบน
                heightFactor: 0.1, //
                child: Image(
                  image: AssetImage('lib/assets/images/FnJ-EWDXkAIOBJE.jpeg'),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  final Function searchTodoList;

  const SearchBox({
    super.key,
    required this.searchTodoList,
  });

  @override
  SearchBoxState createState() => SearchBoxState();
}

class SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: bgWhiteColor, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) {
          print('Search Value ::::: ${value}');
          widget.searchTodoList(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: 'Search',
          hintStyle: TextStyle(color: textColor),
          prefixIcon: Icon(
            Icons.search,
            color: textColor,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
