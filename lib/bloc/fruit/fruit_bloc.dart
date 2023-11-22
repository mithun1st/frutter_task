// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:frutter/controller/service.dart';

part 'fruit_event.dart';
part 'fruit_state.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  FruitBloc() : super(FruitInitial()) {
    List<Map<String, dynamic>> fruit = [];

    on<FruitLoadedEvent>((event, emit) async {
      emit(FruitLoadingState());
      final List<Map<String, dynamic>> fromCsv = await AllServices().getItemFromCsv();

      fruit.clear();
      fruit.addAll(fromCsv);
      emit(FruitLoadedState(fruit));
    });

    on<FruitSearchingEvent>((event, emit) async {
      List<Map<String, dynamic>> fruitFilter = [];

      for (Map<String, dynamic> element in fruit) {
        if (element["ProductCode"].toString().toLowerCase().startsWith(event.keyWord.toString())) {
          fruitFilter.add(element);
        }
      }
      emit(FruitLoadedState(fruitFilter));
    });
  }
}
