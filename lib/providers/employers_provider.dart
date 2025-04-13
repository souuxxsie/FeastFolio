import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class EmployerInfo {
  final String name;
  final String email;
  final String uid;
  final int jobCount;
  final List<String> locations;

  EmployerInfo({
    required this.name,
    required this.email,
    required this.uid,
    required this.jobCount,
    required this.locations,
  });
}


final employersProvider = FutureProvider<List<EmployerInfo>>((ref) async {
  // Fetch all users with usertype == employer
  final usersSnap = await FirebaseFirestore.instance
      .collection('users')
      .where('usertype', isEqualTo: 'employer')
      .get();

  // Fetch all jobs
  final jobsSnap = await FirebaseFirestore.instance.collection('jobs').get();
  final jobs = jobsSnap.docs.map((doc) => doc.data()).toList();

  List<EmployerInfo> employers = [];

  for (var user in usersSnap.docs) {
    final data = user.data();
    final uid = data['uid'];
    final name = data['name'];
    final email = data['email'];

    // Match jobs by postedBy UID
    final userJobs = jobs.where((job) => job['postedBy'] == uid).toList();
    final jobCount = userJobs.length;
    final locations = userJobs.map((job) => job['location'] as String).toSet().toList();

    employers.add(
      EmployerInfo(
        name: name,
        email: email,
        uid: uid,
        jobCount: jobCount,
        locations: locations,
      ),
    );
  }

  return employers;
});
