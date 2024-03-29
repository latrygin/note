import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/screen/note/cubit/note_cubit.dart';
import 'package:note/screen/note/cubit/note_state.dart';

class InputDateWidget extends StatelessWidget {
  const InputDateWidget({super.key});

  void showDatePick(BuildContext context, DateTime? date) {
    showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) => context.read<NoteCubit>().setDate(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return ListTile(
          onTap: () => showDatePick(context, state.task.deadline),
          title: Text(
            S.of(context).get(SName.makeTo),
            style: Theme.of(context).listTileTheme.titleTextStyle,
          ),
          subtitle: state.task.deadline == null
              ? null
              : Text(
                  DateFormat.yMMMMd(Platform.localeName)
                      .format(state.task.deadline!),
                  style: Theme.of(context).listTileTheme.subtitleTextStyle,
                ),
          trailing: Switch(
            value: state.task.deadline != null,
            onChanged: (value) {
              if (value) {
                showDatePick(context, state.task.deadline);
              } else {
                context.read<NoteCubit>().setDate(null);
              }
            },
          ),
        );
      },
    );
  }
}
