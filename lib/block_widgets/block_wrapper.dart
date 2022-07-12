import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final List<Widget> children;
  final Color color;
  const Block({Key? key, required this.children, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        height: 50,
        constraints: BoxConstraints(maxWidth: 800),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: children,
            ),
          ),
        ));
  }
}
