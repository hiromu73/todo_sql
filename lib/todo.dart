

import 'package:flutter/foundation.dart'; // *.freezed.dartで必要なのでimportしておく
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

//Todoのモデルを実装
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    String id,  // uuidで割りつける予定
    String title,
    @Default(false) bool completed,//@Defaultで初期値を与えるpage=0ではない
  }) = TodoData;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

}