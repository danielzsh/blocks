import 'package:blocks/block_widgets/all.dart';
import 'package:flutter/material.dart';
import 'block_wrapper.dart';
import 'drag_wrapper.dart';

class Print extends StatelessWidget {
  final dragKey = GlobalKey<DragAreaState>();
  late final DragArea drag1;
  Print({Key? key}) : super(key: key) {
    drag1 = DragArea(
      key: dragKey,
      options: const {String},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Block(
      color: const Color.fromARGB(255, 2, 66, 118),
      children: [
        const Text(
          "print",
          style: TextStyle(color: Colors.white),
        ),
        Expanded(child: drag1)
      ],
    );
  }
}

class PrintDrag extends StatelessWidget {
  const PrintDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drag(
        data: Print,
        content: 'print ____',
        color: Color.fromARGB(255, 2, 66, 118));
  }
}
