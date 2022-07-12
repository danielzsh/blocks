import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blocks/utility.dart';

class DragArea extends StatefulWidget {
  final Set? options;
  final bool textfield;
  const DragArea({Key? key, this.options, this.textfield = false})
      : super(key: key);

  @override
  State<DragArea> createState() => DragAreaState();
}

class DragAreaState extends State<DragArea> {
  final controller = TextEditingController();
  Widget? content;
  Object data = 0;
  @override
  Widget build(BuildContext context) {
    return DragTarget<Object>(
      builder: (context, candidateData, rejectedData) {
        return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color:
                        candidateData.isNotEmpty ? Colors.red : Colors.black)),
            child: (content == null)
                ? Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: (widget.textfield)
                        ? Container(
                            margin: const EdgeInsets.all(8),
                            child: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ))
                        : null)
                : Draggable<Object>(
                    data: data,
                    feedback: content!,
                    child: content!,
                    childWhenDragging: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onDragCompleted: () {
                      setState(() {
                        content = null;
                      });
                    },
                  ));
      },
      onAccept: (statement) {
        setState(() {
          if (widget.options == null ||
              widget.options!.contains(
                  ((statement is Type) ? statement : statement.runtimeType))) {
            content = buildFromType(statement);
            data = statement;
          }
        });
      },
    );
  }
}
