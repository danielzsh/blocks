import 'package:blocks/block_widgets/all.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'drag_area.dart';
import 'package:blocks/globals.dart';
import 'block_wrapper.dart';

class _DragContent extends StatelessWidget {
  const _DragContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const Center(
          child: Text(
        "change ___ by ___",
        style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none),
      )),
    );
  }
}

class ChangeDrag extends StatelessWidget {
  const ChangeDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Draggable(
        data: ChangeBlock, feedback: _DragContent(), child: _DragContent());
  }
}

class ChangeBlock extends StatefulWidget {
  const ChangeBlock({Key? key}) : super(key: key);

  @override
  State<ChangeBlock> createState() => ChangeBlockState();
}

class ChangeBlockState extends State<ChangeBlock> {
  String changeoption = 'increase';
  final drag1 = GlobalKey<DragAreaState>();
  final drag2 = GlobalKey<DragAreaState>();
  @override
  Widget build(BuildContext context) {
    return Block(
      color: Colors.lightGreen,
      children: [
        DropdownButton(
            value: changeoption,
            items: <String>["increase", "decrease"]
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                  ));
            }).toList(),
            onChanged: (String? newVal) {
              setState(() {
                changeoption = newVal!;
              });
            }),
        Expanded(
            child: DragArea(
          key: drag1,
          options: const {String},
        )),
        const Text("by"),
        Expanded(
            child: DragArea(
          key: drag2,
          textfield: true,
        ))
      ],
    );
  }
}
