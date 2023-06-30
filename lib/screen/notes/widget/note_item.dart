import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/entity/task_importance.dart';
import 'package:note/screen/notes/notes.dart';
import 'package:note/utils/theme/theme.dart';

class NoteWidget extends StatelessWidget {
  final int index;
  final Task task;
  const NoteWidget({
    super.key,
    required this.task,
    required this.index,
  });

  Color purple(Set<MaterialState> states) => Colors.deepPurple;
  Color red(Set<MaterialState> states) => FlutterTheme.colorRedLight;
  Color gray(Set<MaterialState> states) => FlutterTheme.supportSeparatorLight;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await context.read<NotesCubit>().deleteTask(index);
          return true;
        }
        if (direction == DismissDirection.endToStart) {
          await context.read<NotesCubit>().doneTask(index, !task.done);
          return false;
        }
        return null;
      },
      secondaryBackground: DismissibleBackground(
        color: task.done ? Colors.deepPurple : Colors.green,
        icon: task.done ? Icons.close : Icons.done,
      ),
      background: const DismissibleBackground(
        color: Colors.red,
        icon: Icons.delete,
        isRight: false,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
        onTap: () => NavigationManager.instance.openTask(task.id),
        leading: Checkbox.adaptive(
          fillColor: MaterialStateProperty.resolveWith(
            task.done
                ? purple
                : task.importance == TaskImportant.important
                    ? red
                    : gray,
          ),
          value: task.done,
          onChanged: (value) =>
              context.read<NotesCubit>().doneTask(index, value!),
        ),
        title: RichText(
          maxLines: 3,
          text: TextSpan(
            children: [
              if (task.importance == TaskImportant.low && !task.done)
                const WidgetSpan(
                  child: Icon(
                    Icons.arrow_downward,
                    size: 16,
                  ),
                ),
              if (task.importance == TaskImportant.important && !task.done)
                const WidgetSpan(
                  child: Icon(
                    Icons.warning_rounded,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              TextSpan(
                text: task.text,
                style: TextStyle(
                  color: task.done ? Colors.grey : Colors.black,
                  decoration: task.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        subtitle: task.deadline == null
            ? null
            : Text(
                DateFormat.yMMMMd(Platform.localeName).format(task.deadline!),
                style: const TextStyle(color: Colors.deepPurple),
              ),
        trailing: IconButton(
          onPressed: () => NavigationManager.instance.openTask(task.id),
          icon: const Icon(
            Icons.info_outline,
            color: FlutterTheme.labelTertiaryLight,
          ),
        ),
      ),
    );
  }
}
