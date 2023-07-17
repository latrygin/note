import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
        taskLocalDatasource: GetIt.I<TaskLocalDatasource>(),
        taskRemoteDatasource: GetIt.I<TaskRemoteDatasource>(),
        revisionLocalDatasource: GetIt.I<RevisionLocalDatasource>(),
      )..initial(),
      child: const NotesBody(),
    );
  }
}
