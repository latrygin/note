import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/notes/cubit/notes_cubit.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';
import 'package:note/utils/exception/exception.dart';
import 'package:note/utils/l10n/s.dart';
import 'package:note/utils/navigation/navigation.dart';

import 'notes_header.dart';
import 'notes_list.dart';

class NotesBody extends StatefulWidget {
  const NotesBody({super.key});

  @override
  State<NotesBody> createState() => _NotesBodyState();
}

class _NotesBodyState extends State<NotesBody> with RouteAware {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() {}));
    super.initState();
  }

  bool get isAppBar {
    return _scrollController.hasClients &&
        _scrollController.offset > (140 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is NotesFailureState) {
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
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            NotesHeader(isActive: isAppBar),
            const NotesList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => NavigationManager.instance.openTask(null),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NavigationManager.instance.routeAwareObserver.subscribe(
      this,
      ModalRoute.of(context)!,
    );
  }

  @override
  void dispose() {
    NavigationManager.instance.routeAwareObserver.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<NotesCubit>().initial();
    super.didPopNext();
  }
}
