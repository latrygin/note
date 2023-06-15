import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/notes/cubit/notes_cubit.dart';
import 'package:note/utils/logger/logger.dart';
import 'package:note/utils/navigation/navigation.dart';

import 'notes_body.dart';
import 'notes_header.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> with RouteAware {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () => NavigationManager.instance.openTask(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NavigationManager.instance.routeAwareObserver.subscribe(
      this,
      ModalRoute.of(context)!,
    );
  }

  @override
  void dispose() {
    NavigationManager.instance.routeAwareObserver.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<NotesCubit>().initial();
    logger.i('didPopNext');
    super.didPopNext();
  }
}
