import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Box cajita_sorpresa = Hive.box("configs");

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is SaveConfigsEvent) {
      await cajita_sorpresa.putAll(event.configs);
      yield DoneState();
    } else if (event is LoadConfigsEvent) {
      try {
        var juguete = {
          "dropdown": cajita_sorpresa.get("dropdown", defaultValue: "tres"),
          "switch": cajita_sorpresa.get("switch", defaultValue: false),
          "checkbox": cajita_sorpresa.get("checkbox", defaultValue: true),
          "slider": cajita_sorpresa.get("slider", defaultValue: 7.0),
        };
        yield LoadedConfigsState(configs: juguete);
      } catch (e) {
        yield ErrorState(error: e.toString());
      }
    }
  }
}
