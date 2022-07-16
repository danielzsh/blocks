import 'package:blocks/block_widgets/all.dart';
import 'package:blocks/block_widgets/block_wrapper.dart';
import 'package:blocks/block_widgets/drag_wrapper.dart';
import 'package:flutter/material.dart';

class SetDrag extends StatelessWidget {
  const SetDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drag(
        data: SetBlock, content: 'set ____ to ____', color: Colors.orange);
  }
}

class SetBlock extends StatelessWidget {
  final dragkey1 = GlobalKey<DragAreaState>();
  final dragkey2 = GlobalKey<DragAreaState>();
  SetBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Block(children: <Widget>[
      const Text('set', style: TextStyle(color: Colors.white)),
      Expanded(child: DragArea(key: dragkey1, options: const {String})),
      const Text('to', style: TextStyle(color: Colors.white)),
      Expanded(
          child: DragArea(
        key: dragkey2,
        textfield: true,
        options: const {VarBlock},
      )),
    ], color: Colors.orange);
  }
}
