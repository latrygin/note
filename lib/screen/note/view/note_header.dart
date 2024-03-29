import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/screen/note/note.dart';

class NoteHeader extends StatelessWidget implements PreferredSizeWidget {
  const NoteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 4,
      leading: IconButton(
        key: const ValueKey('BackButton'),
        onPressed: () => GetIt.I<Nav>().gotoHome(),
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      actions: [
        TextButton(
          key: const ValueKey('SaveButton'),
          onPressed: () => context.read<NoteCubit>().saveTask(),
          child: Text(S.of(context).get(SName.save)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(54);
}
