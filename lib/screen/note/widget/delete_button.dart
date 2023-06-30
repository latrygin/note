import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/screen/note/cubit/note_state.dart';
import 'package:note/screen/note/note.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return ListTile(
          enabled: !state.create,
          onTap: () => context.read<NoteCubit>().delete(),
          leading: Icon(
            Icons.delete,
            color: !state.create ? Colors.red : Colors.grey,
          ),
          title: Text(
            S.of(context).get(SName.delete),
            style: TextStyle(
              color: !state.create ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
