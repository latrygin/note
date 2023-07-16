import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:note/core/exception/exception.dart';
import 'package:note/core/l10n/s.dart';
import 'package:note/core/navigation/navigation.dart';
import 'package:note/screen/notes/cubit/notes_cubit.dart';
import 'package:note/screen/notes/cubit/notes_state.dart';

import 'notes_header.dart';
import 'notes_list.dart';

class NotesBody extends StatefulWidget {
  const NotesBody({super.key});

  @override
  State<NotesBody> createState() => _NotesBodyState();
}

class _NotesBodyState extends State<NotesBody> with RouteAware {
  late ScrollController _scrollController;
  bool filter = false;

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
        body: MediaQuery.of(context).size.width > 600
            ? Center(
                child: SizedBox(
                  width: 600,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      NotesHeader(
                        isActive: isAppBar,
                        filter: filter,
                        onPressed: () {
                          setState(() {
                            filter = !filter;
                          });
                        },
                      ),
                      NotesList(
                        filter: filter,
                      ),
                    ],
                  ),
                ),
              )
            : CustomScrollView(
                controller: _scrollController,
                slivers: [
                  NotesHeader(
                    isActive: isAppBar,
                    filter: filter,
                    onPressed: () {
                      setState(() {
                        filter = !filter;
                      });
                    },
                  ),
                  NotesList(
                    filter: filter,
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          key: const ValueKey('Floating'),
          onPressed: () => GetIt.I<Nav>().gotoCreateTask(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.endOfFrame.then((value) {
      GetIt.I<RouteObserver>()
          .subscribe(this, ModalRoute.of(context) as PageRoute);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    //context.read<RouteObserver>().unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<NotesCubit>().initial();
    super.didPopNext();
  }
}
