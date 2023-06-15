import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/note/cubit/note_state.dart';
import 'package:note/screen/note/note.dart';
import 'package:note/utils/l10n/s.dart';

class InputTitleWidget extends StatelessWidget {
  const InputTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 6.0,
          ),
          child: state.text == null
              ? TextField(
                  minLines: 4,
                  maxLines: 100,
                  onChanged: (title) =>
                      context.read<NoteCubit>().setTitle(title),
                  decoration: InputDecoration(
                    hintText: S.of(context).get(SName.whatNeeds),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                )
              : TextFormField(
                  initialValue: state.text,
                  minLines: 4,
                  maxLines: 100,
                  onChanged: (title) =>
                      context.read<NoteCubit>().setTitle(title),
                  decoration: InputDecoration(
                    hintText: S.of(context).get(SName.whatNeeds),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
        );
      },
    );
  }
}
