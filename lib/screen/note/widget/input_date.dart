import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/screen/note/cubit/note_cubit.dart';
import 'package:note/screen/note/cubit/note_state.dart';
import 'package:note/utils/l10n/s.dart';

class InputDateWidget extends StatelessWidget {
  const InputDateWidget({super.key});

  void showDatePick(BuildContext context, DateTime? date) {
    showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        context.read<NoteCubit>().setDate(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return ListTile(
          onTap: () => showDatePick(context, state.deadline),
          title: Text(S.of(context).get(SName.makeTo)),
          subtitle: state.deadline == null
              ? null
              : Text(
                  DateFormat.yMMMMd().format(state.deadline!),
                  style: const TextStyle(color: Colors.deepPurple),
                ),
          trailing: Switch(
            value: state.deadline != null,
            onChanged: (value) {
              if (value) {
                showDatePick(context, state.deadline);
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
