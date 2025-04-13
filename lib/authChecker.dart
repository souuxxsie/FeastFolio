import 'package:feastfolio/employerhomescreen.dart';
import 'package:feastfolio/login.dart';
import 'package:feastfolio/userTypechecker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart'; // wherever you put it

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          // User is logged in
          return UserTypeScreen(); // Replace with your home screen
        } else {
          // User is not logged in
          return Login(); // Replace with your login screen
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}
