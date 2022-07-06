import 'package:flutter/material.dart';
import 'block_base.dart';

abstract class IStatement {
  late List<Widget> body;
  void run() {}
}
