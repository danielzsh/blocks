import 'package:flutter/foundation.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _varcontroller = TextEditingController();
  var vars = <VarDrag>[VarDrag(name: "var")];
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _varcontroller.value.text;
    if (text.length == 0) {
      return "Too short";
    }
    if (variables.containsKey(_varcontroller.text)) {
      return "Variable name in use";
    }
    return null;
  }

  @override
  void dispose() {
    _varcontroller.dispose();
    super.dispose();
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: _varcontroller,
            builder: (context, TextEditingValue value, __) {
              return AlertDialog(
                title: Text('Add variable'),
                content: TextField(
                  onChanged: (text) {
                    setState(() => text);
                  },
                  controller: _varcontroller,
                  decoration: InputDecoration(
                      hintText: "Variable name", errorText: _errorText),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK',
                    ),
                    onPressed: () {
                      setState(() {
                        vars.add(VarDrag(name: _varcontroller.text));
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocks'),
      ),
      body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 150,
          child: ListView(controller: ScrollController(), children: [
            const ForDrag(),
            PrintDrag(),
            SetDrag(),
            Container(
              margin: EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () {
                    _displayTextInputDialog(context);
                  },
                  child: const Text('Create variable')),
            ),
            ...vars
          ]),
        ),
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
