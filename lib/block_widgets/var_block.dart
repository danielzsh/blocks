import 'package:flutter/material.dart';
import 'package:blocks/globals.dart';

class VarBlock extends StatefulWidget {
  final String name;
  const VarBlock({Key? key, required this.name}) : super(key: key);
  @override
  State<VarBlock> createState() => VarBlockState();
}

class VarBlockState extends State<VarBlock> {
  late String name;
  @override
  void initState() {
    name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      constraints: const BoxConstraints(minWidth: 200, minHeight: 40),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
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

  void changeName(String newname) {
    setState(() {
      name = newname;
    });
  }
}

class _DragContent extends StatelessWidget {
  final String name;
  const _DragContent({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      constraints: const BoxConstraints(minWidth: 50),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(children: [
        Expanded(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              )),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                homePageKey.currentState!.deleteVar(name);
              },
              icon: const Icon(Icons.delete),
              color: Colors.white,
            )),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                homePageKey.currentState!.editVariable(name);
              },
              icon: const Icon(Icons.edit),
              color: Colors.white,
            ))
      ]),
    );
  }
}

class VarDrag extends StatelessWidget {
  final VarBlock block;
  final String name;
  VarDrag({Key? key, required this.name})
      : block = VarBlock(
          name: name,
        ),
        super(key: key) {
    variables[name] = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        child: Draggable<String>(
            data: name, child: _DragContent(name: name), feedback: block));
  }
}
