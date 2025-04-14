import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';

class AuthController {
  final Ref ref;
  AuthController(this.ref);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String usertype,
  }) async {
    try {
      UserCredential userCredential = await ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      // Create user document in Firestore
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'phone': phone,
        'usertype' : usertype,
        'createdAt': FieldValue.serverTimestamp(),

      });

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      // Handle any other type of error
      return e.toString();
    }
  }


  Future<void> updateUserType(String uid, String userType) async {
    await _firestore.collection('users').doc(uid).update({
      'usertype': userType,
    });
  }

  Future<void> logOut()async{
    await ref.read(firebaseAuthProvider).signOut();
  }


  User? get currentUser => _auth.currentUser;
}
