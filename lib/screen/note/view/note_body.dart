import 'package:flutter/material.dart';
import 'package:note/screen/note/widget/delete_button.dart';

import '../widget/widget.dart';

class NoteBody extends StatelessWidget {
  const NoteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          InputTitleWidget(),
          InputPriorityWidget(),
          Divider(height: 1, indent: 16, endIndent: 16),
          InputDateWidget(),
          Divider(height: 1),
          DeleteButtonWidget(),
        ],
      ),
    );
  }
}
