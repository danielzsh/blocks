import 'package:flutter/material.dart';
import 'block_base.dart';

abstract class IStatement implements Block {
  late List<IStatement> body;
  void run() {}
}
