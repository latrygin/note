import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/screen/notes/notes.dart';

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
                if (state.tasks == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.tasks!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.tasks!.length) {
                      return const InputWidget();
                    } else {
                      return NoteWidget(
                        task: state.tasks![index],
                      );
                    }
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
