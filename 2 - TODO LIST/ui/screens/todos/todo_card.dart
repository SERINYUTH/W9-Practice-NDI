import 'package:flutter/material.dart';

import '../../../models/todo.dart';
import '../../theme/app_screen.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo, required this.onTap});

  final Todo todo;
  final ValueChanged<Todo> onTap;
 

  //  TODO
  //  Update the widget to disaply both state (completed / not completed) as required
  //
  TextDecoration? get textDecoration => 
    todo.completed ? TextDecoration.lineThrough : null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(todo),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: BoxBorder.all(width: 2, color: AppTheme.yellowColor),
          ),

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CheckBox(checked: todo.completed),
                SizedBox(width: 10),
                Text(
                  todo.title,
                  style: AppTheme.paragraph.copyWith(
                    decoration: textDecoration,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckBox extends StatelessWidget {
  const CheckBox({super.key, required this.checked});

  final bool checked;


  //  TODO
  //  Update the widget to disaply both state (completed / not completed) as required
  //
  BoxBorder? get border =>
    checked ? null : Border.all(width: 2, color: AppTheme.yellowColor);
  Color? get backbroundColor =>
    checked ? AppTheme.greenColor : Colors.white;
  Widget? get innerIcon =>
    checked ? Icon(Icons.check, color: Colors.white) : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: border,
        color: backbroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: innerIcon,
    );
  }
}
