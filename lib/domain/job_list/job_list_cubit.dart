import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/jobs_list_model.dart';
import '../../network/network.dart';

part 'job_list_state.dart';

class JobListCubit extends Cubit<JobListState> {
  JobListCubit() : super(JobListInitial());
  List<JobsListModel?>? jobs = [];

  getJobList() async {
    emit(JobListLoading());

    try {
      log('IN VER');
      log("https://www.unhcrjo.org/jobs/api");
      var response = await Network.get(
        url: "https://www.unhcrjo.org/jobs/api",
      );

      log(response.data.toString());

      // String data = response.data;
      //
      // data.replaceAll('\n', '');

      dynamic jsonResponse = response.data;
      jobs = jsonResponse.map<JobsListModel?>((job) {
        return JobsListModel.fromJson(job);
      }).toList();

      emit(JobListSuccess(jobs: jobs));
    } catch (e) {
      emit(JobListError(message: "something went wrong"));
    }
  }
}
