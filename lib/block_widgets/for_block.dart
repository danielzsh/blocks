import 'package:blocks/block_widgets/all.dart';
import 'package:blocks/utility.dart';
import 'package:flutter/material.dart';
import 'all.dart';
import 'package:blocks/keys.dart';

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
    return const Draggable<Type>(
      data: For,
      feedback: _DragContent(),
      child: _DragContent(),
    );
  }
}

class For extends StatefulWidget {
  const For({Key? key}) : super(key: key);
  @override
  State<For> createState() => ForState();
}

class ForState extends State<For> implements IStatement {
  var drag1 = const DragArea(options: {String});
  var drag2 = const DragArea();
  @override
  Widget build(BuildContext context) {
    var children = body.map((e) {
      return Container(margin: const EdgeInsets.only(left: 16), child: e);
    });
    return ListView(shrinkWrap: true, children: [
      DragTarget<Type>(
        builder: (context, candidateData, rejectedData) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: candidateData.isNotEmpty
                          ? Colors.red
                          : Colors.black)),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text('for', style: TextStyle(color: Colors.white)),
                      Expanded(child: drag1),
                      const Text('in', style: TextStyle(color: Colors.white)),
                      Expanded(child: drag2),
                    ],
                  )));
        },
        onAccept: (statement) {
          print('setting state');
          outputKey.currentState!.print("printed");
          setState(() {
            body.add(buildFromType(statement));
          });
        },
      ),
      ...children
    ]);
  }

  @override
  var body = <Widget>[];

  @override
  void run() {}
}
