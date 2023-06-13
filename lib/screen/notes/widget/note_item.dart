import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/screen/notes/notes.dart';
import 'package:note/utils/theme/theme.dart';

class NoteWidget extends StatelessWidget {
  final int index;
  final Task task;
  const NoteWidget({super.key, required this.task, required this.index});

  Color green(Set<MaterialState> states) => FlutterTheme.colorGreenLight;
  Color red(Set<MaterialState> states) => FlutterTheme.colorRedLight;
  Color gray(Set<MaterialState> states) => FlutterTheme.supportSeparatorLight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      child: Dismissible(
        direction: DismissDirection.horizontal,
        key: UniqueKey(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            context.read<NotesCubit>().deleteTask(index);
            return true;
          }
          if (direction == DismissDirection.endToStart) {
            context.read<NotesCubit>().doneTask(index, !task.isDone);
            return false;
          }
        },
        // onDismissed: (direction) {
        //   if (direction == DismissDirection.startToEnd) {
        //     context.read<NotesCubit>().delete(index);
        //   }
        //   if (direction == DismissDirection.endToStart) {
        //     context.read<NotesCubit>().done(index, !task.isDone);
        //   }
        // },
        secondaryBackground: Container(
          padding: const EdgeInsets.only(right: 24),
          decoration:
              BoxDecoration(color: task.isDone ? Colors.blue : Colors.green),
          alignment: Alignment.centerRight,
          child: task.isDone
              ? const Icon(Icons.close, color: Colors.white)
              : const Icon(Icons.done, color: Colors.white),
        ),
        background: Container(
          padding: const EdgeInsets.only(left: 24),
          decoration: const BoxDecoration(color: Colors.red),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ListTile(
          onTap: () {},
          leading: Checkbox.adaptive(
            fillColor:
                MaterialStateProperty.resolveWith(task.isDone ? green : gray),
            value: task.isDone,
            onChanged: (bool? value) =>
                context.read<NotesCubit>().doneTask(index, value!),
          ),
          title: Text(
            task.title,
            maxLines: 3,
            style: TextStyle(
                decoration: task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          subtitle: task.date == null ? null : Text(task.date.toString()),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline,
              color: FlutterTheme.labelTertiaryLight,
            ),
          ),
        ),
      ),
    );
  }
}
