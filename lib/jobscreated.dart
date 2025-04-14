import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/jobs_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/jobs_controller.dart';

class JobsCreatedScreen extends ConsumerStatefulWidget {
  const JobsCreatedScreen({super.key});

  @override
  ConsumerState<JobsCreatedScreen> createState() => _JobsCreatedScreenState();
}

class _JobsCreatedScreenState extends ConsumerState<JobsCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    final userJobsStream = ref.watch(userPostedJobsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Jobs Created',
          style: TextStyle(
            fontFamily: 'signika',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: userJobsStream.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (snapshot) {
          final jobs = snapshot.docs;

          if (jobs.isEmpty) {
            return const Center(
              child: Text(
                'You haven’t posted any jobs yet.',
                style: TextStyle(fontFamily: 'poppins', fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index].data() as Map<String, dynamic>;

              final jobTitle = job['jobPosition'] ?? 'N/A';
              final applicants = job['totalApplicants'] ?? 0;
              final type = job['employmentType'] ?? 'N/A';
              final vacancies = job['vacancies'] ?? 1;
              final postedOn = (job['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
              final salary = job['salary'] ?? 0;

              return jobCard(
                jobTitle: jobTitle,
                applicants: applicants,
                jobType: type,
                vacancies: vacancies,
                postedOn: postedOn,
                salary: salary,
              );
            },
          );
        },
      ),
    );
  }

  Widget jobCard({
    required String jobTitle,
    required int applicants,
    required String jobType,
    required int vacancies,
    required DateTime postedOn,
    required int salary,
  }) {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(postedOn);

    return Container(
      margin: const EdgeInsets.all(8),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/hotel.png'),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  jobTitle.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '$vacancies Vacancies · ',
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 10,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      '$applicants Applicants',
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 10,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    tagsTile(jobTitle),
                    const SizedBox(width: 8),
                    tagsTile(jobType),
                  ],
                ),
                const SizedBox(height: 8),
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
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                '₹$salary Per Annum',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              top: 0,
              right: 0,
              child: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }

  Widget tagsTile(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 8),
        ),
      ),
    );
  }
}
