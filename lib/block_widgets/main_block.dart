import 'package:blocks/globals.dart';
import 'package:flutter/material.dart';
import 'package:blocks/utility.dart';
import 'all.dart';

class _DragBlockWrapper extends StatefulWidget {
  final Widget child;
  final int ind;
  const _DragBlockWrapper({Key? key, required this.child, required this.ind})
      : super(key: key);

  @override
  State<_DragBlockWrapper> createState() => __DragBlockWrapperState();
}

class __DragBlockWrapperState extends State<_DragBlockWrapper> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: widget.child,
      feedback: widget.child,
      childWhenDragging: Container(),
      data: widget.child,
      onDragCompleted: () {
        setState(() {
          mainKey.currentState!.delete(widget.ind);
        });
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  var body = <Widget>[];

  void delete(int ind) {
    print(ind);
    print(body);
    setState(() {
      body.removeAt(ind);
    });
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    print("build" + body.toString());
    var children = body.asMap().entries.map(
      (e) {
        return _DragBlockWrapper(child: e.value, ind: e.key);
      },
    );
    return ListView(controller: ScrollController(), children: [
      DragTarget<Object>(
        builder: ((context, candidateData, rejectedData) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: candidateData.isNotEmpty
                          ? Colors.red
                          : Colors.black)),
              height: 40,
              margin: const EdgeInsets.all(4),
              child: Container(
                  margin: const EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'on start: ',
                    style: TextStyle(color: Colors.white),
                  )));
        }),
        onAccept: (statement) {
          if (statement is Type) {
            setState(() {
              body.add(buildFromType(statement));
            });
          } else if (statement is Widget) {
            setState(() {
              body.add(statement);
            });
          }
        },
      ),
      ...children,
    ]);
  }
}
