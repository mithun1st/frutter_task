part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

class FeedbackImageState extends FeedbackState {}

class FeedbackRecordState extends FeedbackState {}
