import 'package:flutter/material.dart';
import 'block_widgets/all.dart';
import 'keys.dart';

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
    for (Widget s in mainKey.currentState!.body) {
      run(s);
    }
  }
  if (statement is Print) {
    final val = statement.dragKey.currentState!.content as VarBlock;
    outputKey.currentState!.print(val.val.value.toString());
  }
}
