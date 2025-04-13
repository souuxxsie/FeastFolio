import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobApplicationController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> applyForJob({
    required String jobId,
  }) async {
    try {
      final applicantId = _auth.currentUser?.uid;
      if (applicantId == null) return 'User not logged in';

      // Check for duplicate application
      final existing = await _firestore
          .collection('job_applications')
          .where('jobId', isEqualTo: jobId)
          .where('applicantId', isEqualTo: applicantId)
          .get();

      if (existing.docs.isNotEmpty) return 'Already applied';

      // Get recruiterId from job
      final jobDoc = await _firestore.collection('jobs').doc(jobId).get();
      if (!jobDoc.exists) return 'Job not found';

      final recruiterId = jobDoc.data()?['postedBy'];
      if (recruiterId == null) return 'Recruiter info missing';

      // Create application
      await _firestore.collection('job_applications').add({
        'jobId': jobId,
        'applicantId': applicantId,
        'recruiterId': recruiterId,
        'appliedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
