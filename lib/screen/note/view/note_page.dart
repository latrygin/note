import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/provider/revision/local_revision_provider_impl.dart';
import 'package:note/domain/provider/task/task_provider_impl.dart';
import 'package:note/domain/service/task/task_service_impl.dart';
import 'package:note/screen/note/cubit/note_cubit.dart';
import 'package:note/screen/note/cubit/note_state.dart';
import 'package:note/utils/exception/exception.dart';
import 'package:note/utils/l10n/s.dart';

import 'note_body.dart';
import 'note_header.dart';

class NotePage extends StatelessWidget {
  final String? id;
  const NotePage({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(
        taskService: context.read<TaskServiceImpl>(),
        taskProvider: context.read<TaskProviderImpl>(),
        localRevisionProvider: context.read<LocalRevisionProviderImpl>(),
      )..initial(id),
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteFailureState) {
            late String message;
            switch (state.error) {
              case BadRequestException():
                message = S.of(context).get(SName.badRequest);
              case UnauthorizedException():
                message = S.of(context).get(SName.unauthorized);
              case NotFoundException():
                message = S.of(context).get(SName.notFound);
              case ServerErrorException():
                message = S.of(context).get(SName.serverError);
              case NotInternetException():
                message = S.of(context).get(SName.notInternet);
              case UnknownException():
                message = S.of(context).get(SName.unknownException);
              default:
                message = S.of(context).get(SName.veryUnknownException);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
        child: const Scaffold(
          appBar: NoteHeader(),
          body: NoteBody(),
        ),
      ),
    );
  }
}
