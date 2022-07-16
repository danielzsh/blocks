import 'package:blocks/block_widgets/all.dart';
import 'package:flutter/material.dart';
import 'drag_area.dart';
import 'drag_wrapper.dart';
import 'block_wrapper.dart';

class ChangeDrag extends StatelessWidget {
  const ChangeDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drag(
        data: ChangeBlock,
        content: 'change ___ by ___',
        color: Colors.lightGreen);
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
            child:
                DragArea(key: drag2, textfield: true, options: const {String}))
      ],
    );
  }
}
