import 'package:flutter/material.dart';
import 'package:blocks/block_widgets/all.dart';
import 'globals.dart';
import 'utility.dart';
import 'package:google_fonts/google_fonts.dart';

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
          fontFamily: GoogleFonts.ubuntu().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(key: homePageKey));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var vars = <String>["my variable"];
  final _varcontroller = TextEditingController();
  String? get _errorText {
    final text = _varcontroller.value.text;
    if (text.isEmpty) {
      return "Too short";
    }
    if (text.length > 25) return "Too long";
    if (variables.containsKey(_varcontroller.text)) {
      return "Variable name in use";
    }
    return null;
  }

  void deleteVar(String name) {
    variables.remove(name);
    setState(() {
      vars.remove(name);
    });
  }

  void editVariable(String name) async {
    _varcontroller.text = name;
    await _displayTextInputDialog(context, "Edit variable");
    variables[_varcontroller.text] = variables[name] ?? 0;
    variables.remove(name);
    for (final key in varmap[name]!) {
      key.currentState!.changeName(_varcontroller.text);
    }
    varmap[_varcontroller.text] = varmap[name]!;
    varmap.remove(name);
    setState(() {
      vars.remove(name);
    });
  }

  @override
  void dispose() {
    _varcontroller.dispose();
    super.dispose();
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, String text) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: _varcontroller,
            builder: (context, TextEditingValue value, __) {
              return AlertDialog(
                title: Text(text),
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
                    child: const Text(
                      'OK',
                    ),
                    onPressed: (_errorText != null)
                        ? null
                        : () {
                            setState(() {
                              vars.add(_varcontroller.text);
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

  Future<void> _displayConfirmDialog(
      BuildContext context, String text, VoidCallback onPressed) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                ),
                onPressed: () {
                  onPressed();
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
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
        SizedBox(
          width: 300,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    const PrintDrag(),
                    const SetDrag(),
                    const ChangeDrag(),
                    Container(
                        margin: const EdgeInsets.all(8),
                        child: Container(
                          margin: const EdgeInsets.only(top: 32),
                          child: ElevatedButton(
                              onPressed: () {
                                _displayTextInputDialog(
                                    context, "Add variable");
                              },
                              child: const Text('Create variable')),
                        )),
                    ...vars.map((name) => VarDrag(name: name)),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DragTarget<Object>(
                  builder: ((context, candidateData, rejectedData) {
                    return Tooltip(
                      message:
                          "Drag statement here to delete, click to delete all",
                      child: IconButton(
                          iconSize: 100,
                          icon: const Icon(
                            Icons.delete,
                          ),
                          color: candidateData.isNotEmpty
                              ? Colors.red
                              : Colors.black,
                          onPressed: () {
                            _displayConfirmDialog(context, "Delete all blocks?",
                                () {
                              mainKey.currentState!.clear();
                            });
                          }),
                    );
                  }),
                  onAccept: (statement) {
                    if (statement is DragBlockWrapper) {
                      mainKey.currentState!.delete(statement.ind);
                    }
                  },
                ),
              )
            ],
          ),
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
      /* bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 100),
                child: DragTarget<DragBlockWrapper>(
                  builder: ((context, candidateData, rejectedData) {
                    return Icon(
                      Icons.delete,
                      color:
                          candidateData.isNotEmpty ? Colors.red : Colors.black,
                      size: 100,
                    );
                  }),
                  onAccept: (statement) {
                    // mainKey.currentState!.delete(statement.ind);
                  },
                ),
              ),
            ],
          )), */
    );
  }
}
