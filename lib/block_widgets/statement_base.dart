import 'package:flutter/material.dart';

abstract class IStatement {
  late List<IStatement> body;
  late String type;
  void run() {}
  Widget build(BuildContext context) {
    return Container();
  }
}
