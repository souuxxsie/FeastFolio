import 'package:feastfolio/controllers/auth_controller.dart';
import 'package:feastfolio/yellowbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  void logOut(BuildContext context) async {
    final authController = ref.read(authControllerProvider);
    authController.logOut();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: GestureDetector(
          onTap: (){
            logOut(context);
          },
          child: Yellowbutton(text: 'Log Out'),
        ),
      ),
    );
  }
}
