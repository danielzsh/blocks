import 'package:blocks/block_widgets/all.dart';
import 'package:flutter/material.dart';

class Print extends StatelessWidget {
  final dragKey = GlobalKey<DragAreaState>();
  late DragArea drag1;
  Print({Key? key}) : super(key: key) {
    drag1 = DragArea(key: dragKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 60,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 2, 66, 118)),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          const Text(
            "print",
            style: TextStyle(color: Colors.white),
          ),
          Expanded(child: drag1)
        ],
      ),
    );
  }
}

class _DragContent extends StatelessWidget {
  const _DragContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 40,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 2, 66, 118)),
      padding: const EdgeInsets.all(8),
      child: const Text("print _____",
          style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              fontSize: 14)),
    );
  }
}

class PrintDrag extends StatelessWidget {
  const PrintDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Draggable(
      data: Print,
      child: _DragContent(),
      feedback: _DragContent(),
    );
  }
}