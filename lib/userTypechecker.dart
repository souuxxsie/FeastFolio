import 'package:feastfolio/employeehomescreen.dart';
import 'package:feastfolio/employerhomescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class UserTypeScreen extends ConsumerStatefulWidget {
  const UserTypeScreen({super.key});

  @override
  ConsumerState<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends ConsumerState<UserTypeScreen> {

  @override
  Widget build(BuildContext context) {


    final userAsync = ref.watch(userProvider);
    return userAsync.when(
        data: (userData){
          if (userData == null) return const Text("No user data found.");
          if(userData['usertype']=='employer'){
            return EmployerHomeScreen();
          }
          else{
            return Employeehomescreen();
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text("Error: $err"),
    );

  }
}
