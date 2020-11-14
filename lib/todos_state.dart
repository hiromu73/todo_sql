


import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:todo_sql/todo.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'todos_state.freezed.dart';


@freezed
abstract class TodosState with _$TodosState {
  const factory TodosState({//TodosStateのクラスをチェック
    @Default(<Todo>[]) List<Todo> todos,//すべてのTodoが入るtodos
  }) = TodosStateData;//TodosStateDataであればデータの読み込みが終わったという判断ができるように
  const factory TodosState.loading() = TodosStateLoading;//TodosStateLoadingであればまだ読み込み中
}

class TodosController extends StateNotifier<TodosState> with LocatorMixin  {
//LocatorMixinをmixinする事でcontextにあるproviderへのアクセスを容易する
  TodosController() : super(const TodosState.loading());

  final _uuid = Uuid();

  @override
  void initState() async {
    super.initState();
    await Future<void>.delayed(const Duration(seconds: 3));//initStateで3秒間ウエイトを入れ,初期データとしていくつかのTodoをstateへ設定
    // 初期データを設定、TodosStateLoadingからTodoStateDataへ変わるのでローディング完了の状態となる

    var prefs = await SharedPreferences.getInstance();

    final todosJson = prefs.getString('todos');
    final todos = json.decode(todosJson).map<Todo>((json) => Todo.fromJson(json)).toList();

    if (todos == null) {
      state = TodosStateData(
          todos: [
            Todo(id: _uuid.v4(),title: 'テスト'),
          ]
      );
    }
    state = TodosState(
        todos: todos
    );

    // if (todos == null) {
    //   state = TodosState(
    //     todos: [
    //       Todo(id: _uuid.v4(),title: 'テスト'),
    //     ]
    //   );
    // }
    //  state = TodosState(
    //   todos: todos
    // );
  }

// [ Todo(id: _uuid.v4(), title: 'テスト'),

  void add(String title) async {//追加機能
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentState =  state;
    if (currentState is TodosStateData) {
      // todosのクローンに新しいTodoを追加してstateを更新
      final todos = currentState.todos.toList()
        ..add(
          Todo(id: _uuid.v4(), title: title),
        );
      final todosJson = json.encode(todos);
      prefs.setString('todos', todosJson);

      state = currentState.copyWith(//stateはimmutableでメンバ変数を直接変更することはできないので、stateを更新するときは現在のstateからcopyWithでコピーするか、新規のstateで上書きする
        todos: todos,
      );

    }
  }

  void toggle(Todo todo) {//未完了/完了
    final currentState = state;
    if (currentState is TodosStateData) {
      // Todoを検索してcomplatedをtoggleし、stateを更新
      final todos = currentState.todos.map((t) {
        if (t == todo) {//map()与えられた各要素に処理を掛けた後に、その要素群に対する新しいリストを作成する。
          return t.copyWith(
            completed: !t.completed,
          );
        }
        return t;
      }).toList();
      state = TodosState(
        todos: todos,
      );
    }
  }
}
