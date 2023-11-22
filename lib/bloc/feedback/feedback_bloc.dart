// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<FeedbackImageEvent>((event, emit) {
      emit(FeedbackImageState());
    });
    
    on<FeedbackRecordEvent>((event, emit) {
      emit(FeedbackRecordState());
    });

  }
}
