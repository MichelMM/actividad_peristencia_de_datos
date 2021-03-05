part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class DoneState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedConfigsState extends HomeState {
  final Map<String, dynamic> configs;

  LoadedConfigsState({@required this.configs});
  @override
  List<Object> get props => [configs];
}

class ErrorState extends HomeState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
