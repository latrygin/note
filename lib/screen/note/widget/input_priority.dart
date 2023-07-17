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
            title: Text(
              S.of(context).get(SName.priority),
              style: Theme.of(context).listTileTheme.titleTextStyle,
            ),
            subtitle: Text(
              switch (state.task.importance) {
                TaskImportant.basic => S.of(context).get(SName.nonePriority),
                TaskImportant.low => S.of(context).get(SName.lowPriority),
                TaskImportant.important => S.of(context).get(SName.highPriority)
              },
              style:
                  Theme.of(context).listTileTheme.subtitleTextStyle!.copyWith(
                        color: switch (state.task.importance) {
                          TaskImportant.basic => Colors.grey,
                          TaskImportant.low => null,
                          TaskImportant.important => Colors.red
                        },
                      ),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<TaskImportant>(
              value: TaskImportant.basic,
              child: Text(
                S.of(context).get(SName.nonePriority),
                style: Theme.of(context).popupMenuTheme.textStyle,
              ),
            ),
            PopupMenuItem<TaskImportant>(
              value: TaskImportant.low,
              child: Text(
                S.of(context).get(SName.lowPriority),
                style: Theme.of(context).popupMenuTheme.textStyle,
              ),
            ),
            PopupMenuItem<TaskImportant>(
              value: TaskImportant.important,
              child: Text(
                S.of(context).get(SName.highPriority),
                style: Theme.of(context)
                    .popupMenuTheme
                    .textStyle!
                    .copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
