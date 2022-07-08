import 'package:flutter/material.dart';
import 'block_widgets/all.dart';
import 'globals.dart';

Widget buildFromType(Object type) {
  if (type is Type) {
    if (type == For) {
      return For(
        key: GlobalKey<ForState>(),
      );
    }
    if (type == Print) {
      return Print();
    }
    if (type == SetBlock) {
      return SetBlock();
    }
  }
  if (type is String) {
    return VarBlock(val: Var(type));
  }
  return Text("widget not found$type",
      style: TextStyle(
        color: Colors.white,
      ));
}

void run(Widget statement) {
  if (statement is Main) {
    outputKey.currentState!.clear();
    for (Widget s in mainKey.currentState!.body) {
      run(s);
    }
  }
  if (statement is Print) {
    if (statement.dragKey.currentState!.content == null) return;
    final val = statement.dragKey.currentState!.content as VarBlock;
    outputKey.currentState!.print(variables[val.val.name].toString());
  }
  if (statement is SetBlock) {
    if (statement.dragkey2.currentState!.content == null &&
        statement.dragkey2.currentState!.widget.textfield == true) {
      variables[
              (statement.dragkey1.currentState!.content as VarBlock).val.name] =
          int.tryParse(statement.dragkey2.currentState!.controller.text) ?? 0;
    }
  }
}
