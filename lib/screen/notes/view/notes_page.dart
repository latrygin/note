import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:note/domain/repository/task_local_impl.dart';
import 'package:note/domain/repository/task_remote_impl.dart';

import '../notes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(
        taskLocalDatasource: context.read<TaskLocalDatasource>(),
        taskRemoteDatasource: context.read<TaskRemoteDatasource>(),
        revisionLocalDatasource: context.read<RevisionLocalDatasource>(),
      )..initial(),
      child: const NotesBody(),
    );
  }
}
