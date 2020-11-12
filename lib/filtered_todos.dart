


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sql/filtered_todos_state.dart';
import 'package:todo_sql/todo.dart';
import 'package:todo_sql/todos_state.dart';

class FilteredTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<TodosState>().when(
      // TodosStateDataの場合
          (_) {
        final todos = context
            .select<FilteredTodosState, List<Todo>>((state) => state.todos);
        // return todos == null
        //   ? Container()
         return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: todos.length,
          itemBuilder: (_, index) {
            final todo = todos[index];
            return _buildCard(context, todo);
          },
        );
      },
      // TodosStateLoadingの場合
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCard(BuildContext context, Todo todo) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        trailing: IconButton(
          icon: Icon(
            Icons.done,
            color: todo.completed ? Colors.green : Colors.grey,
          ),
          onPressed: () => context.read<TodosController>().toggle(todo),
        ),
      ),
    );
  }
}