import 'package:flutter/material.dart';
import 'statement_base.dart';

class DragArea extends StatefulWidget {
  const DragArea({Key? key}) : super(key: key);

  @override
  State<DragArea> createState() => _DragAreaState();
}

class _DragAreaState extends State<DragArea> {
  IStatement? content;
  @override
  Widget build(BuildContext context) {
    return DragTarget<IStatement>(
      builder: (context, candidateData, rejectedData) {
        return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color:
                        candidateData.isNotEmpty ? Colors.red : Colors.black)),
            child: content == null
                ? Container(
                    decoration: const BoxDecoration(color: Colors.white),
                  )
                : content?.build(context));
      },
      onAccept: (statement) {
        setState(() {
          content = statement;
        });
      },
    );
  }
}
