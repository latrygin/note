import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/screen/notes/notes.dart';

class NotesList extends StatelessWidget {
  final bool filter;

  const NotesList({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Card(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                if (state.tasks == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Column(
                  children: [
                    AnimatedSize(
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 500),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.tasks!.length,
                        itemBuilder: (context, index) {
                          final data = state.tasks![index];
                          if (filter) {
                            if (!data.done) {
                              return NoteWidget(
                                key: ValueKey<String>(data.id),
                                index: index,
                                task: data,
                              );
                            } else {
                              return const SizedBox();
                            }
                          } else {
                            return NoteWidget(
                              key: ValueKey<String>(data.id),
                              index: index,
                              task: data,
                            );
                          }
                        },
                      ),
                    ),
                    const InputWidget()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
