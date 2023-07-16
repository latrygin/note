import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/core/navigation/delegate.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/entity/task_importance.dart';
import 'package:note/screen/notes/notes.dart';

class NoteWidget extends StatelessWidget {
  final int index;
  final Task task;
  const NoteWidget({
    super.key,
    required this.task,
    required this.index,
  });

  Color purple(Set<MaterialState> states) => Colors.deepPurple;
  Color red(Set<MaterialState> states) => Colors.red;
  Color gray(Set<MaterialState> states) => Colors.grey;

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
        onTap: () => context.read<TaskRouterDelegate>().gotoTask(task.id),
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
                    color: Colors.grey,
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
                style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                      decoration: task.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.done ? Colors.grey : null,
                    ),
              ),
            ],
          ),
        ),
        subtitle: task.deadline == null
            ? null
            : Text(
                DateFormat.yMMMMd(Platform.localeName).format(task.deadline!),
                style: Theme.of(context).listTileTheme.subtitleTextStyle,
              ),
        trailing: IconButton(
          onPressed: () => context.read<TaskRouterDelegate>().gotoTask(task.id),
          icon: const Icon(
            Icons.info_outline,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
