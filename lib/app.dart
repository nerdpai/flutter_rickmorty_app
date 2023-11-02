import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickmorty_application/feature/data/repositories/character_server_repository.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/character_bloc/character_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_events.dart'
    as list_events;
import 'package:flutter_rickmorty_application/feature/presentation/pages/main_page.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/theme.dart';

class App extends StatelessWidget {
  const App({required this.repository, super.key});
  final CharacterServerRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ListBloc(repository: repository)
            ..add(const list_events.TryFetchAllInfo()),
        ),
        BlocProvider(
          create: (_) => CharacterBloc(repository: repository),
        ),
      ],
      child: MaterialApp(
        theme: MyTheme.darkTheme(),
        home: const MainPage(),
        scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
