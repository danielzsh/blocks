import 'package:blocks/block_widgets/all.dart';
import 'package:blocks/block_widgets/block_base.dart';
import 'package:flutter/material.dart';
import 'package:blocks/globals.dart';

class VarBlock extends StatelessWidget implements Block {
  final String name;
  final bool center;
  const VarBlock({Key? key, required this.name, this.center = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      constraints: BoxConstraints(minWidth: 50),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        alignment: (center) ? Alignment.center : null,
        child: Text(
          name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

class VarDrag extends StatelessWidget {
  final VarBlock block;
  final String name;
  VarDrag({Key? key, required this.name})
      : block = VarBlock(
          name: name,
          center: true,
        ),
        super(key: key) {
    variables[name] = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Draggable<String>(data: name, child: block, feedback: block));
  }
}
