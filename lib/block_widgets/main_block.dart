import 'package:flutter/material.dart';
import 'package:blocks/utility.dart';
import 'all.dart';

class _DragBlockWrapper extends StatefulWidget {
  final Widget child;
  const _DragBlockWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<_DragBlockWrapper> createState() => __DragBlockWrapperState();
}

class __DragBlockWrapperState extends State<_DragBlockWrapper> {
  bool dropped = false;
  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: dropped ? Container() : widget.child,
      feedback: widget.child,
      childWhenDragging: Container(),
      data: widget.child,
      onDragCompleted: () {
        setState(() {
          dropped = true;
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
  @override
  var body = <Widget>[];
  @override
  Widget build(BuildContext context) {
    var children = body.map(
      (e) {
        return _DragBlockWrapper(child: e);
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
          print(statement.runtimeType);
          setState(() {
            if (statement is Type)
              body.add(buildFromType(statement));
            else if (statement is Widget) {
              print('worked');
              body.add(statement);
            }
          });
        },
      ),
      ...children,
    ]);
  }
}
