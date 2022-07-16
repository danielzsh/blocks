import 'package:flutter/material.dart';

class _DragContent extends StatelessWidget {
  final String content;
  final Color color;
  const _DragContent({Key? key, required this.content, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: 300,
      height: 40,
      margin: const EdgeInsets.all(8),
      child: Container(
          margin: const EdgeInsets.all(8),
          child: Center(
            child: Text(content,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal)),
          )),
    );
  }
}

class Drag extends StatelessWidget {
  final Object data;
  final String content;
  final Color color;
  const Drag(
      {Key? key,
      required this.data,
      required this.content,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Draggable<Object>(
      data: data,
      feedback: _DragContent(content: content, color: color),
      child: _DragContent(content: content, color: color),
    );
  }
}
