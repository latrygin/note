import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/screen/notes/cubit/notes_cubit.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';

class NotesHeader extends StatelessWidget {
  final bool isActive;
  final bool filter;
  final void Function()? onPressed;
  const NotesHeader({
    super.key,
    required this.isActive,
    required this.filter,
    required this.onPressed,
  });

  static const expandedHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      title: isActive ? Text(S.of(context).get(SName.myTask)) : null,
      actions: isActive
          ? [
              BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: onPressed,
                    //onPressed: () => context.read<NotesCubit>().filter(),
                    icon: Icon(
                      filter ? Icons.visibility_off : Icons.visibility,
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
        title: isActive
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).get(SName.myTask),
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                state is NotesSuccessState
                                    ? S.of(context).withValue(
                                          SName.done,
                                          getCountDone(state.tasks),
                                        )
                                    : S.of(context).get(SName.loading),
                                style: Theme.of(context)
                                    .appBarTheme
                                    .toolbarTextStyle,
                              ),
                              if (state is NotesSuccessState)
                                const SizedBox()
                              else
                                SizedBox.fromSize(
                                  size: const Size(8, 8),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                ),
                            ],
                          ),
                          InkWell(
                            onTap: onPressed,
                            child: Icon(
                              filter
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
    if (tasks == null) {
      return 0;
    }
    var i = 0;
    for (final element in tasks) {
      if (element.done) i++;
    }
    return i;
  }
}
