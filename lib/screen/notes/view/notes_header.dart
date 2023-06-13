import 'package:flutter/material.dart';
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
        widget.scrollController.offset > (expandedHeight - kToolbarHeight - 10);
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      title: isAppBar ? Text(S.of(context).get('my_task')) : null,
      actions: isAppBar
          ? [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.deepPurple,
                ),
              )
            ]
          : null,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(right: 20, left: 60, bottom: 8),
        title: isAppBar
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).get('my_task'),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Выполнено - 5',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Icon(
                        Icons.remove_red_eye,
                        size: 18,
                        color: Colors.deepPurple,
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
