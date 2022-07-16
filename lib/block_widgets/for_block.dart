import 'package:blocks/block_widgets/all.dart';
import 'package:blocks/utility.dart';
import 'package:flutter/material.dart';
import 'all.dart';
import 'drag_wrapper.dart';

class ForDrag extends StatelessWidget {
  const ForDrag({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Drag(
        data: For, content: 'for ___ in ____', color: Colors.black);
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
    return ListView(
        shrinkWrap: true,
        controller: ScrollController(),
        children: [
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
                          const Text('for',
                              style: TextStyle(color: Colors.white)),
                          Expanded(child: drag1),
                          const Text('in',
                              style: TextStyle(color: Colors.white)),
                          Expanded(child: drag2),
                        ],
                      )));
            },
            onAccept: (statement) {
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
