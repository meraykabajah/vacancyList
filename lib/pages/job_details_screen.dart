import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/jobs_list_model.dart';
import '../widget/Seperator.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobsListModel? job;

  const JobDetailsScreen({super.key, this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.job!.title ?? ""),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Hero(
                        tag: widget.job?.jobId ?? '',
                        child: Image.network(
                          widget.job?.imageUrl ?? '',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.job?.company ?? '',
                            // style: const TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: 16,
                            // ),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            widget.job?.datePosted ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                buildSpacer(),
                buildTitleValue(title: "Salary: ", value: widget.job?.salary),
                buildSpacer(),
                buildTitleValue(title: "Location:", value: widget.job?.location),
                buildSpacer(),
                buildTitleValue(title: "Job Id:", value: widget.job?.jobId),
                buildSpacer(),
                const Separator(),
                buildSpacer(),
                Text(widget.job!.description ?? ""),
                buildSpacer(),
                const Separator(),
                buildSpacer(),
                Text(widget.job!.longDescription ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSpacer() => const SizedBox(height: 10);

  Row buildTitleValue({String? title, String? value}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value ?? "",
          ),
        ),
      ],
    );
  }
}
