import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/jobs_controller.dart';


final jobsProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});


final jobsControllerProvider = Provider<JobsController>((ref) {
  return JobsController(ref);
});


