part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackEvent {}

class FeedbackImageEvent extends FeedbackEvent{}

class FeedbackRecordEvent extends FeedbackEvent{}