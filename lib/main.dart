import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blocks',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Blocks'),
            ),
            body: Row(children: [
              Draggable<IStatement>(
                  data: For(), feedback: ForDrag(), child: ForDrag()),
              Main(),
            ])));
  }
}

abstract class IStatement {
  late List<IStatement> body;
  void run() {}
  Widget build(BuildContext context) {
    return Container();
  }
}

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> implements IStatement {
  @override
  var body = <IStatement>[];
  @override
  void run() {}
  @override
  Widget build(BuildContext context) {
    var children = body.map(
      (e) {
        return e.build(context);
      },
    );
    return DragTarget<IStatement>(
      builder: ((context, candidateData, rejectedData) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
                      'main',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ]..addAll(children));
      }),
      onAccept: (statement) {
        setState(() {
          body.add(statement);
        });
      },
    );
  }
}

class ForDrag extends StatelessWidget {
  const ForDrag({Key? key}) : super(key: key);

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

class For extends StatelessWidget implements IStatement {
  For({Key? key}) : super(key: key);
  @override
  var body = <IStatement>[];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        width: 320,
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Text('for', style: TextStyle(color: Colors.white)),
                Expanded(child: TextBox()),
                Text('in range', style: TextStyle(color: Colors.white)),
                Expanded(child: TextBox()),
                Text('to', style: TextStyle(color: Colors.white)),
                Expanded(child: TextBox()),
              ],
            )));
  }

  @override
  void run() {}
}

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
