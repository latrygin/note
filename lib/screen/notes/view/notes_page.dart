import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/facade/task_facade.dart';

import '../notes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  static final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(
        taskFacade: context.read<TaskFacade>(),
      )..initial(),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            NotesHeader(
              scrollController: _scrollController,
            ),
            const NotesBody(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 160),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
