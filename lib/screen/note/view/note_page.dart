import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/revision/local_revision_provider_impl.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/domain/service/task/task_service_impl.dart';
import 'package:note/screen/note/cubit/note_cubit.dart';
import 'package:note/screen/note/cubit/note_state.dart';

import 'note_body.dart';
import 'note_header.dart';

class NotePage extends StatelessWidget {
  final String? id;
  const NotePage({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(
        taskService: context.read<TaskServiceImpl>(),
        taskProvider: context.read<TaskProviderImpl>(),
        localRevisionProvider: context.read<LocalRevisionProviderImpl>(),
      )..initial(id),
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: const Scaffold(
          appBar: NoteHeader(),
          body: NoteBody(),
        ),
      ),
    );
  }
}
