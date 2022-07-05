import 'package:blocks/block_widgets/all.dart';
import 'package:blocks/block_widgets/block_base.dart';
import 'package:flutter/material.dart';

class Var {
  int value = 0;
  final String name;
  Var(this.name);
}

class VarBlock extends StatelessWidget implements Block {
  final Var val;
  const VarBlock({Key? key, required this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        val.name,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class VarDrag extends StatelessWidget {
  final VarBlock block;
  const VarDrag({Key? key, required this.block}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Draggable<Block>(data: block, child: block, feedback: block);
  }
}
