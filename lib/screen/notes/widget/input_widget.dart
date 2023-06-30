import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/screen/notes/notes.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 16,
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {
              context.read<NotesCubit>().addTask(_controller.text);
              _controller.clear();
            },
            icon: const Icon(Icons.add),
          ),
          hintText: S.of(context).get(SName.newTask),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
