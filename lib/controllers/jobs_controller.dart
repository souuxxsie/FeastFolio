import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/jobs_provider.dart';

class JobsController {
  final Ref ref;
  JobsController(this.ref);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createJob({
    required String jobPosition,
    required String workplaceType,
    required String employmentType,
    required String location,
    required String company,
    required String description,
    required int salary,
    required int vacancies,
    required int experience,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        return "User not logged in.";
      }

      await _firestore.collection('jobs').add({
        'jobPosition': jobPosition,
        'workplaceType': workplaceType,
        'employmentType': employmentType,
        'location': location,
        'company': company,
        'description': description,
        'postedBy': uid,
        'salary' : salary,
        'vacancies' : vacancies,
        'experience' : experience,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString(); // catch any unexpected errors
    }
  }


}
final userPostedJobsStreamProvider = StreamProvider<QuerySnapshot>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // Return an empty stream if user is null
    return const Stream<QuerySnapshot>.empty();
  }
  return FirebaseFirestore.instance
      .collection('jobs')
      .where('postedBy', isEqualTo: user.uid)
      .snapshots();
});

final AllJobsStreamProvider = StreamProvider<QuerySnapshot>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const Stream<QuerySnapshot>.empty();
  }
  return FirebaseFirestore.instance
      .collection('jobs')
      .snapshots();
});

final jobsByUidStreamProvider = StreamProvider.family<QuerySnapshot, String>((ref, uid) {
  return FirebaseFirestore.instance
      .collection('jobs')
      .where('postedBy', isEqualTo: uid)
      .snapshots();
});

final getJobsByIdProvider = FutureProvider.family<Map<String, dynamic>?, String>((ref, jobId) async{

  final job =  await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();
  return job.data();

} );
