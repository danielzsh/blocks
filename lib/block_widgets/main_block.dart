import 'package:blocks/globals.dart';
import 'package:flutter/material.dart';
import 'package:blocks/utility.dart';
import 'all.dart';

class DragBlockWrapper extends StatefulWidget {
  final Widget child;
  final int ind;
  const DragBlockWrapper({Key? key, required this.child, required this.ind})
      : super(key: key);

  @override
  State<DragBlockWrapper> createState() => _DragBlockWrapperState();
}

class _DragBlockWrapperState extends State<DragBlockWrapper> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              child: Draggable<DragBlockWrapper>(
                child: widget.child,
                feedback: widget.child,
                childWhenDragging: Container(),
                data: widget,
                /* onDragCompleted: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      mainKey.currentState!.delete(widget.ind);
                    });
                  });
                }, */
              ),
            ),
            candidateData.isNotEmpty
                ? Container(
                    height: 50,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  )
                : Container(),
          ],
        );
      },
      onWillAccept: (statement) {
        return (statement is Type || statement is DragBlockWrapper);
      },
      onAccept: (statement) {
        if (statement is Type) {
          setState(() {
            mainKey.currentState!.add(buildFromType(statement), widget.ind + 1);
          });
        } else if (statement is DragBlockWrapper) {
          mainKey.currentState!.delete(statement.ind);
          mainKey.currentState!.add(statement.child,
              (statement.ind <= widget.ind) ? widget.ind : widget.ind + 1);
        }
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

  void add(Widget statement, int ind) {
    setState(() {
      if (ind >= body.length) {
        body.add(statement);
      } else {
        body.insert(ind, statement);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build" + body.toString());
    var children = body.asMap().entries.map(
      (e) {
        return DragBlockWrapper(child: e.value, ind: e.key);
      },
    );
    return ListView(controller: ScrollController(), children: [
      DragTarget<Object>(
        builder: ((context, candidateData, rejectedData) {
          return Column(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 40,
                  margin: const EdgeInsets.all(4),
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'on start: ',
                        style: TextStyle(color: Colors.white),
                      ))),
              candidateData.isNotEmpty
                  ? Container(
                      height: 50,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )
                  : Container(),
            ],
          );
        }),
        onWillAccept: (statement) {
          return (statement is Type || statement is DragBlockWrapper);
        },
        onAccept: (statement) {
          if (statement is Type) {
            setState(() {
              add(buildFromType(statement), 0);
            });
          } else if (statement is DragBlockWrapper) {
            setState(() {
              delete(statement.ind);
              add(statement.child, 0);
            });
          }
        },
      ),
      ...children,
    ]);
  }
}
