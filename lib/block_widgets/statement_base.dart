import 'package:flutter/material.dart';

abstract class IStatement {
  late List<Widget> body;
  void run() {}
}
