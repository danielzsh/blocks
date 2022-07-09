import 'package:flutter/material.dart';
import 'package:blocks/utility.dart';
import 'all.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> implements IStatement {
  @override
  var body = <Widget>[];
  @override
  void run() {}
  @override
  Widget build(BuildContext context) {
    var children = body.map(
      (e) {
        return e;
      },
    );
    return ListView(controller: ScrollController(), children: [
      DragTarget<Type>(
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
              margin: const EdgeInsets.all(8),
              child: Container(
                  margin: const EdgeInsets.all(8),
                  child: const Text(
                    'on start: ',
                    style: TextStyle(color: Colors.white),
                  )));
        }),
        onAccept: (statement) {
          setState(() {
            body.add(buildFromType(statement));
          });
        },
      ),
      ...children,
    ]);
  }
}
