import 'package:feastfolio/controllers/auth_controller.dart';
import 'package:feastfolio/yellowbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class Profilescreen extends ConsumerStatefulWidget {
  const Profilescreen({super.key});

  @override
  ConsumerState<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends ConsumerState<Profilescreen> {

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
