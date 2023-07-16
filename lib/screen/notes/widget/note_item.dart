// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/domain/entity/task.dart';
import 'package:note/domain/entity/task_importance.dart';
import 'package:note/screen/notes/notes.dart';

class NoteWidget extends StatefulWidget {
  final int index;
  final Task task;

  const NoteWidget({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  double? height;

  Color purple(Set<MaterialState> states) => Colors.deepPurple;

  Color red(Set<MaterialState> states) => Colors.red;

  Color gray(Set<MaterialState> states) => Colors.grey;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 500),
      child: Dismissible(
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            setState(() {
              height = 0;
            });
            await context.read<NotesCubit>().deleteTask(widget.index);
          }
          if (direction == DismissDirection.endToStart) {
            await context.read<NotesCubit>().doneTask(
                  widget.index,
                  !widget.task.done,
                );
            return false;
          }
          return null;
        },
        secondaryBackground: DismissibleBackground(
          color: widget.task.done ? Colors.deepPurple : Colors.green,
          icon: widget.task.done ? Icons.close : Icons.done,
        ),
        background: const DismissibleBackground(
          color: Colors.red,
          icon: Icons.delete,
          isRight: false,
        ),
        key: UniqueKey(),
        child: SizedBox(
          height: height,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
            onTap: () => GetIt.I<Nav>().gotoTask(widget.task.id),
            leading: Checkbox.adaptive(
              fillColor: MaterialStateProperty.resolveWith(
                widget.task.done
                    ? purple
                    : widget.task.importance == TaskImportant.important
                        ? red
                        : gray,
              ),
              value: widget.task.done,
              onChanged: (value) =>
                  context.read<NotesCubit>().doneTask(widget.index, value!),
            ),
            title: RichText(
              maxLines: 3,
              text: TextSpan(
                children: [
                  if (widget.task.importance == TaskImportant.low &&
                      !widget.task.done)
                    const WidgetSpan(
                      child: Icon(
                        Icons.arrow_downward,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  if (widget.task.importance == TaskImportant.important &&
                      !widget.task.done)
                    const WidgetSpan(
                      child: Icon(
                        Icons.warning_rounded,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  TextSpan(
                    text: widget.task.text,
                    style: Theme.of(context)
                        .listTileTheme
                        .titleTextStyle!
                        .copyWith(
                          decoration: widget.task.done
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: widget.task.done ? Colors.grey : null,
                        ),
                  ),
                ],
              ),
            ),
            subtitle: widget.task.deadline == null
                ? null
                : Text(
                    DateFormat.yMMMMd(Platform.localeName)
                        .format(widget.task.deadline!),
                    style: Theme.of(context).listTileTheme.subtitleTextStyle,
                  ),
            trailing: IconButton(
              onPressed: () => GetIt.I<Nav>().gotoTask(widget.task.id),
              icon: const Icon(
                Icons.info_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
