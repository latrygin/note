import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/notes/notes.dart';
import 'package:note/screen/notes/widget/note_item.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

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
                if (state.task == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.task!.length,
                  itemBuilder: (context, index) {
                    return NoteWidget(
                      index: index,
                      task: state.task![index],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
