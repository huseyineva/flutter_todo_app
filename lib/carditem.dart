import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class Carditem extends StatefulWidget {
  const Carditem({super.key, required this.task});
  final Todo task;

  @override
  State<Carditem> createState() => _CarditemState();
}

class _CarditemState extends State<Carditem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          /*
                    widget.task.type == TaskType.note
              ? Image.asset("lib/assets/images/category_1.png")
              : widget.task.type == TaskType.contest
                  ? Image.asset("lib/assets/images/category_2.png")
                  : Image.asset("lib/assets/images/category_3.png"),
           */
          Image.asset("lib/assets/images/category_1.png"),
          Expanded(
            child: Column(children: [
              Text(widget.task.todo!,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: widget.task.completed!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Text(
                "User: ${widget.task.userId!}",
                style: TextStyle(
                    decoration: widget.task.completed!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ]),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                widget.task.completed = !widget.task.completed!;
                isChecked = value!;
              });
            },
          )
        ]),
      ),
    );
  }
}
