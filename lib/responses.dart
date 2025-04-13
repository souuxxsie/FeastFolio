import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/jobApplicationControllerProvider.dart';
import '../controllers/jobs_controller.dart';
import '../providers/user_provider.dart';

class Responses extends ConsumerStatefulWidget {
  const Responses({super.key});

  @override
  ConsumerState<Responses> createState() => _ResponsesState();
}

class _ResponsesState extends ConsumerState<Responses> {
  @override
  Widget build(BuildContext context) {
    final job_applications = ref.watch(userRecruiterApplicationsProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Responses',
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
            job_applications.when(
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
                    final jobId = data['jobId'];
                    final appliedAtTimestamp = data['appliedAt'];
                    final appliedAt = appliedAtTimestamp?.toDate() ?? DateTime.now();

                    final jobDetailsAsync = ref.watch(getJobsByIdProvider(jobId));
                    final applicantAsync = ref.watch(userByIdProvider(applicantId));

                    return jobDetailsAsync.when(
                      data: (jobData) {

                        final jobTitle  = jobData?['jobPosition'] ?? 'Unknown Job';
                        return applicantAsync.when(
                          data: (applicantData) {
                            final applicantName = applicantData?['name'] ?? 'Unknown User';

                            return responseTile(applicantName, jobTitle, appliedAt);
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

  Widget responseTile(String employee, String jobTitle, DateTime datetime) {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(datetime);

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ColoredBox(
                    color: Color.fromRGBO(255, 132, 175, 1.0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '$employee applied for ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: jobTitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: Color.fromRGBO(27, 27, 140, 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to profile
                      },
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'poppins',
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // TODO: Handle delete
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red[700],
                  fontFamily: 'poppins',
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
