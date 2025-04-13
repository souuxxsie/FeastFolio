import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_provider.dart';

final userProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final authUser = ref.watch(authStateProvider).value;

  if (authUser == null) return null;

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(authUser.uid)
      .get();

  return doc.data();
});

final userByIdProvider = FutureProvider.family<Map<String, dynamic>?, String>((ref, uid) async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();

  return doc.data();
});
