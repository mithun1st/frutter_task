part of 'fruit_bloc.dart';

@immutable
sealed class FruitEvent {}

class FruitLoadedEvent extends FruitEvent {}

class FruitSearchingEvent extends FruitEvent {
  final String keyWord;
  FruitSearchingEvent(this.keyWord);
}
