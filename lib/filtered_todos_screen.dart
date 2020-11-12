




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sql/filtered_todos.dart';
import 'package:todo_sql/filtered_todos_state.dart';
import 'package:todo_sql/todos_state.dart';

//FilteredTodos Widgetの表示や、未完了/完了の切り替え、
// 新しいTodoの追加を行うための画面、FilteredTodosScreenを実装します。
class FilteredTodosScreen extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Todo'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.done_all,
              color: context.select<FilteredTodosState, bool>(//未完了/完了のどちらを表示
                      (state) => state.completed)
                  ? Colors.white
                  : Colors.grey),
          onPressed: () {
            context.read<FilteredTodosController>().toggle();//toggleを実行させてリストを更新
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(child: FilteredTodos()),
        _buildPanel(context),
      ],
    );
  }

  Widget _buildPanel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'タイトル',
                filled: false,
              ),
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              var title = _textEditingController.value.text;
              if (title.isEmpty) {
                title = 'No Title';
              }
              context.read<TodosController>().add(title);
              _textEditingController.clear();
            },
          ),
        ],
      ),
    );
  }
}