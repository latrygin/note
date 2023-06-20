import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/screen/note/cubit/note_cubit.dart';

import 'note_body.dart';
import 'note_header.dart';

class NotePage extends StatelessWidget {
  final int? id;
  const NotePage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(
        id: id,
        taskFacade: context.read<TaskProviderImpl>(),
      )..initial(),
      child: const Scaffold(
        appBar: NoteHeader(),
        body: NoteBody(),
      ),
    );
  }
}
