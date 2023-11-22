part of 'fruit_bloc.dart';

@immutable
sealed class FruitState {}

final class FruitInitial extends FruitState {}

final class FruitLoadingState extends FruitState {}

final class FruitLoadedState extends FruitState {
  final List<Map<String, dynamic>> fruit;
  FruitLoadedState(this.fruit);
}
