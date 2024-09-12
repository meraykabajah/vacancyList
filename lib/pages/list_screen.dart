import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancy/domain/theme_cubit/theme_cubit.dart';

import '../domain/job_list/job_list_cubit.dart';
import '../injection.dart';
import '../model/jobs_list_model.dart';
import '../network/network.dart';
import '../utils/app_shared_prefrenses.dart';
import '../widget/Seperator.dart';
import 'job_details_screen.dart';

class JobsListScreen extends StatefulWidget {
  const JobsListScreen({super.key, required this.title});

  final String title;

  @override
  State<JobsListScreen> createState() => _JobsListScreenState();
}

class _JobsListScreenState extends State<JobsListScreen> {
  final gobListCubit = sl<JobListCubit>();

  @override
  void initState() {
    super.initState();
    Network.init();
    gobListCubit.getJobList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            actions: [
              ToggleButtons(
                isSelected: [
                  Theme.of(context).brightness == Brightness.light,
                  Theme.of(context).brightness == Brightness.dark,
                ],
                onPressed: (index) {
                  if (index == 0) {
                    setState(() {
                      sl<ThemeCubit>().changeTheme(false);
                    });
                  } else {
                    setState(() {
                      sl<ThemeCubit>().changeTheme(true);
                    });
                  }
                },
                children: const [
                  Icon(Icons.light_mode),
                  Icon(Icons.dark_mode),
                ],
              ),
            ],
          ),
          body: BlocConsumer<JobListCubit, JobListState>(
            bloc: gobListCubit,
            listener: (context, state) {
              if (state is JobListError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message ?? ""),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is JobListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(const Duration(seconds: 1), () {
                        gobListCubit.getJobList();
                      });
                    },
                    child: buildList()),
              );
            },
          )),
    );
  }

  ListView buildList() {
    return ListView.builder(
      itemCount: gobListCubit.jobs?.length ?? 0,
      itemBuilder: (context, index) {
        final job = gobListCubit.jobs![index];
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailsScreen(job: job),
                ),
              );
            },
            child: buildCard(job),
          ),
        );
      },
    );
  }

  Widget buildCard(JobsListModel? job) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: job?.jobId ?? '',
                child: Image.network(
                  job?.imageUrl ?? '',
                  height: 65,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job?.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      job?.company ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      job?.datePosted ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )),
            ],
          ),
          buildSpacer(),
          const Separator(),
          buildSpacer(),
          Text(job?.description ?? ''),
          buildSpacer(),
        ],
      ),
    );
  }

  SizedBox buildSpacer() => const SizedBox(height: 5);
}
