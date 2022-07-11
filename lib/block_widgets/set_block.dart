import 'package:blocks/block_widgets/all.dart';
import 'package:blocks/block_widgets/block_wrapper.dart';
import 'drag_area.dart';
import 'package:flutter/material.dart';

class _DragContent extends StatelessWidget {
  const _DragContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 40,
      width: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.orange,
      ),
      padding: const EdgeInsets.all(8),
      child: const Center(
        child: Text("set ____ to ____",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                fontSize: 14)),
      ),
    );
  }
}

class SetDrag extends StatelessWidget {
  const SetDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Draggable(
        data: SetBlock, feedback: _DragContent(), child: _DragContent());
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
      Expanded(child: DragArea(key: dragkey1, options: {String})),
      const Text('to', style: TextStyle(color: Colors.white)),
      Expanded(
          child: DragArea(
        key: dragkey2,
        textfield: true,
      )),
    ], color: Colors.orange);
  }
}
