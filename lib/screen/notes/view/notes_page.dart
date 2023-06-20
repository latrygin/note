import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';

import '../notes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(
        taskFacade: context.read<TaskProviderImpl>(),
      )..initial(),
      child: const NotesView(),
    );
  }
}
