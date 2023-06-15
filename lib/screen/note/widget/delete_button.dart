import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/note/cubit/note_state.dart';
import 'package:note/screen/note/note.dart';
import 'package:note/utils/l10n/s.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return ListTile(
          enabled: state.id != null,
          onTap: () => context.read<NoteCubit>().delete(),
          leading: Icon(
            Icons.delete,
            color: state.id != null ? Colors.red : Colors.grey,
          ),
          title: Text(
            S.of(context).get(SName.delete),
            style: TextStyle(
              color: state.id != null ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
