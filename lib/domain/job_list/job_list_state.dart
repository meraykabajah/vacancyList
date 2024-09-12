part of 'job_list_cubit.dart';

@immutable
sealed class JobListState {}

final class JobListInitial extends JobListState {}

final class JobListLoading extends JobListState {}

final class JobListError extends JobListState {
  final String? message;

  JobListError({this.message});
}

final class JobListSuccess extends JobListState {
  final List<JobsListModel?>? jobs;

   JobListSuccess({this.jobs});
}
