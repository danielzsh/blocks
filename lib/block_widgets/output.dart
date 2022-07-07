import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  @override
  State<Output> createState() => OutputState();
}

class OutputState extends State<Output> {
  String text = "Output:\n";
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }

  void print(String message) {
    setState(() {
      text = "$text$message\n";
    });
  }
}
