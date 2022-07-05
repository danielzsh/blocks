import 'package:flutter/material.dart';
import 'statement_base.dart';
import 'drag_area.dart';

class TextBox extends StatelessWidget {
  const TextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white),
        ));
  }
}

class _DragContent extends StatelessWidget {
  const _DragContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 100,
      height: 40,
      margin: const EdgeInsets.all(8),
      child: Container(
          margin: const EdgeInsets.all(8),
          child: const Text('for ___ in ____',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal))),
    );
  }
}

class ForDrag extends StatelessWidget {
  const ForDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<IStatement>(
        data: ForState(),
        feedback: const _DragContent(),
        child: const _DragContent());
  }
}

class For extends StatefulWidget {
  const For({Key? key}) : super(key: key);

  @override
  State<For> createState() => ForState();
}

class ForState extends State<For> implements IStatement {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Text('for', style: TextStyle(color: Colors.white)),
                Expanded(child: DragArea(options: {ForState})),
                Text('in', style: TextStyle(color: Colors.white)),
                Expanded(child: DragArea()),
              ],
            )));
  }

  @override
  var body = <IStatement>[];

  @override
  void run() {}
}
