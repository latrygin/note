import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/domain/entity/task_importance.dart';
import 'package:note/screen/note/cubit/note_state.dart';
import 'package:note/screen/note/note.dart';

class InputPriorityWidget extends StatelessWidget {
  const InputPriorityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return PopupMenuButton<TaskImportant>(
          onSelected: (priority) =>
              context.read<NoteCubit>().setPriority(priority),
          child: ListTile(
            title: Text(S.of(context).get(SName.priority)),
            subtitle: Text(
              state.task.importance == TaskImportant.basic
                  ? S.of(context).get(SName.nonePriority)
                  : state.task.importance == TaskImportant.low
                      ? S.of(context).get(SName.lowPriority)
                      : S.of(context).get(SName.highPriority),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<TaskImportant>(
              value: TaskImportant.basic,
              child: Text(
                S.of(context).get(SName.nonePriority),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            PopupMenuItem<TaskImportant>(
              value: TaskImportant.low,
              child: Text(
                S.of(context).get(SName.lowPriority),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            PopupMenuItem<TaskImportant>(
              value: TaskImportant.important,
              textStyle: const TextStyle(color: Colors.red),
              child: Text(
                S.of(context).get(SName.highPriority),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
