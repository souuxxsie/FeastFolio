import 'package:flutter/material.dart';
import 'yourjobstile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/jobApplicationControllerProvider.dart';
import '../controllers/jobs_controller.dart';
import '../providers/user_provider.dart';

class Employeenoti extends ConsumerStatefulWidget {
  const Employeenoti({super.key});

  @override
  ConsumerState<Employeenoti> createState() => _EmployeenotiState();
}

class _EmployeenotiState extends ConsumerState<Employeenoti> {



  @override
  Widget build(BuildContext context) {

    final yourjobs = ref.watch(userSeekerApplicationsProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your Jobs',
          style: TextStyle(
            fontFamily: 'signika',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            yourjobs.when(
              data: (snapshot) {
                final responses = snapshot.docs;
                if (responses.isEmpty) {
                  return const Center(child: Text('No applications found.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: responses.length,
                  itemBuilder: (context, index) {
                    final data = responses[index].data();
                    final applicantId = data['applicantId'];
                    final recruiterId = data['recruiterId'];
                    final jobId = data['jobId'];
                    final appliedAtTimestamp = data['appliedAt'];
                    final appliedAt = appliedAtTimestamp?.toDate() ?? DateTime.now();
                    final jobstatus = data?['status']??"N/A";

                    final jobDetailsAsync = ref.watch(getJobsByIdProvider(jobId));
                    final recruiterAsync = ref.watch(userByIdProvider(recruiterId));

                    return jobDetailsAsync.when(
                      data: (jobData) {

                        final jobTitle  = jobData?['jobPosition'] ?? 'Unknown Job';

                        // final dateTime = jobData?['appliedAt']??DateTime(2025, 4, 8, 10, 0);
                        return recruiterAsync.when(
                          data: (recruiterData) {
                            final recruiterName = recruiterData?['name'] ?? 'Unknown User';

                            return YourJobsTile(imageUrl: "", restaurantName: recruiterName, jobtitle: jobTitle, status: jobstatus, dateTime: appliedAt);
                          },
                          loading: () => const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          error: (error, stackTrace) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Error loading applicant: $error'),
                          ),
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (error, stackTrace) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Error loading job: $error'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}
