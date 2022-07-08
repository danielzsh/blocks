import 'package:flutter/material.dart';
import 'package:blocks/block_widgets/all.dart';
import 'globals.dart';
import 'utility.dart';

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
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocks'),
      ),
      body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(children: [
          const ForDrag(),
          VarDrag(block: VarBlock(val: Var("var"))),
          PrintDrag(),
          SetDrag()
        ]),
        Flexible(
            flex: 10,
            child: Column(children: [
              Flexible(flex: 2, child: Main(key: mainKey)),
              Flexible(flex: 1, child: Output(key: outputKey))
            ])),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          run(const Main());
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
