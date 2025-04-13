import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/jobApplicationController.dart';

final jobApplicationControllerProvider = Provider((ref) => JobApplicationController());

final recruiterApplicationsProvider = FutureProvider.family((ref, String recruiterId) {
  return FirebaseFirestore.instance
      .collection('job_applications')
      .where('recruiterId', isEqualTo: recruiterId)
      .orderBy('appliedAt', descending: true)
      .snapshots();
});

final userRecruiterApplicationsProvider = FutureProvider<QuerySnapshot<Map<String, dynamic>>>((ref){

  final uid = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance.collection('job_applications')
      .where('recruiterId',isEqualTo: uid)
      .get();
});

final userSeekerApplicationsProvider = FutureProvider<QuerySnapshot<Map<String, dynamic>>>((ref){

  final uid = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance.collection('job_applications')
      .where('applicantId',isEqualTo: uid)
      .get();
});

final hasUserAppliedProvider = FutureProvider.family<bool, String>((ref, jobId) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return false;

  final snapshot = await FirebaseFirestore.instance
      .collection('job_applications')
      .where('jobId', isEqualTo: jobId)
      .where('applicantId', isEqualTo: uid)
      .get();

  return snapshot.docs.isNotEmpty;
});
