import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/note/note.dart';
import 'package:note/utils/l10n/s.dart';
import 'package:note/utils/navigation/navigation.dart';

class NoteHeader extends StatelessWidget implements PreferredSizeWidget {
  const NoteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 4,
      leading: IconButton(
        onPressed: NavigationManager.instance.pop,
        icon: const Icon(Icons.close),
      ),
      actions: [
        TextButton(
          onPressed: () => context.read<NoteCubit>().saveTask(),
          child: Text(S.of(context).get(SName.save)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(54);
}
