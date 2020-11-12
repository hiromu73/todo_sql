//
//
//
// import 'dart:async';
// import 'dart:core';
// import 'package:todo_sql/todo.dart';
// import 'package:todo_sql/database.dart';
//
// class TodoBloc {
//
//   final _todoController = StreamController<List<Todo>>();
//   Stream<List<Todo>> get todoStream => _todoController.stream;
//
//   getTodo() async {
//     _todoController.sink.add(await DB.db.getAllTodo());
//   }
//
//   TodoBloc() {
//     getTodo();
//   }
//
//   dispose() {
//     _todoController.close();
//   }
//
//   create(Todo todo) {
//     // todo.assignUUID();
//     todo.assingnUUID();
//     DB.db.createTodo(todo);
//     getTodo();
//   }
//
//   update(Todo todo) {
//     DB.db.updateTodo(todo);
//     getTodo();
//   }
//
//   delete(String id) {
//     DB.db.deleteTodo(id);
//     getTodo();
//   }
// }