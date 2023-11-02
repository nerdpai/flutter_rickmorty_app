import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_events.dart'
    as list_events;
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_states.dart'
    as list_states;
import 'package:flutter_rickmorty_application/feature/presentation/widgets/characters_grid.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/theme.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  static const Map<Type, Widget Function(BuildContext, list_states.State)>
      statesMap = {
    list_states.Loading: _loadingState,
    list_states.Loaded: _loadedState,
    list_states.InternetFailure: _internetFailureState,
    list_states.ServerFailure: _serverFailureState,
  };

  static Widget _loadingState(BuildContext context, list_states.State state) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget _loadedState(BuildContext context, list_states.State state) {
    final loaded = state as list_states.Loaded;
    return Center(
      child: CharactersGrid(
        countOfElements: loaded.info.count,
      ),
    );
  }

  static Widget _internetFailureState(
      BuildContext context, list_states.State state) {
    final failure = state as list_states.InternetFailure;
    return _failureState(context, Icons.wifi_off_sharp, failure.message);
  }

  static Widget _serverFailureState(
      BuildContext context, list_states.State state) {
    final failure = state as list_states.ServerFailure;
    return _failureState(
        context, Icons.developer_board_off_sharp, failure.message);
  }

  static Widget _failureState(
      BuildContext context, IconData icon, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 200.0,
            color: MyTheme.thirdyTextColor,
          ),
          SizedBox(
            width: 200,
            child: Text(
              message,
              style: const TextStyle(
                color: MyTheme.thirdyTextColor,
                fontSize: 40,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          IconButton(
            onPressed: () {
              context.read<ListBloc>().add(const list_events.TryFetchAllInfo());
            },
            iconSize: 70,
            icon: const Icon(
              Icons.refresh,
              color: MyTheme.secondaryTextColor,
            ),
          ),
          const Text(
            'Try again',
            style: TextStyle(color: MyTheme.secondaryTextColor, fontSize: 20),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
      child:
          BlocBuilder<ListBloc, list_states.State>(builder: (context, state) {
        return statesMap[state.runtimeType]!(context, state);
      }),
    );
  }
}
