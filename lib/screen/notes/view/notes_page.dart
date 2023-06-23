import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/revision/local_revision_provider_impl.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/domain/service/task/task_service_impl.dart';

import '../notes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(
        taskProvider: context.read<TaskProviderImpl>(),
        taskService: context.read<TaskServiceImpl>(),
        localRevisionProvider: context.read<LocalRevisionProviderImpl>(),
      )..initial(),
      child: const NotesBody(),
    );
  }
}
