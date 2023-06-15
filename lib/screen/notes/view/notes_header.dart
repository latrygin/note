import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/screen/notes/cubit/notes_cubit.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/utils/l10n/s.dart';

class NotesHeader extends StatefulWidget {
  const NotesHeader({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<NotesHeader> createState() => _NotesHeaderState();
}

class _NotesHeaderState extends State<NotesHeader> {
  static const expandedHeight = 160.0;

  @override
  void initState() {
    widget.scrollController.addListener(() => setState(() {}));
    super.initState();
  }

  bool get isAppBar {
    return widget.scrollController.hasClients &&
        widget.scrollController.offset > (expandedHeight - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      title: isAppBar ? Text(S.of(context).get(SName.myTask)) : null,
      actions: isAppBar
          ? [
              BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () => context.read<NotesCubit>().filter(),
                    icon: Icon(
                      state.filter == FilterTask.all
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.deepPurple,
                    ),
                  );
                },
              ),
            ]
          : null,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          right: 20,
          left: 68,
          bottom: 8,
        ),
        title: isAppBar
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).get(SName.myTask),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).withValue(SName.done, getCountDone(state.tasks)),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          InkWell(
                            onTap: () => context.read<NotesCubit>().filter(),
                            child: Icon(
                              state.filter == FilterTask.all
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.deepPurple,
                              size: 20,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }

  int getCountDone(List<Task>? tasks) {
    if(tasks == null){
      return 0;
    }
    var i = 0;
    for (final element in tasks) {
      if (element.done) i++;
    }
    return i;
  }
}
