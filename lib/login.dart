import 'package:feastfolio/employeehome.dart';
import 'package:feastfolio/employeehomescreen.dart';
import 'package:feastfolio/employerhome.dart';
import 'package:feastfolio/employerhomescreen.dart';
import 'package:feastfolio/jobcategory.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  void signIn(BuildContext context) async {
    final authController = ref.read(authControllerProvider);
    final uid = await authController.signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-in failed. Please check credentials.')),
      );
      return;
    }

    // ✅ uid is available, fetch Firestore user type
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userType = userDoc.data()?['usertype'];
    print("UserType: $userType");

    if (userType == 'employee') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Employeehomescreen()),
      );
    } else if (userType == 'employer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmployerHomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unknown user type.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.orangeAccent
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          // Circular Image in Center
          Positioned(
            top: MediaQuery.of(context).size.height/15,
            child: SizedBox(

              child: Image.asset(
                "assets/images/sapiens.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(

              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  )
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:20, vertical: 50 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget('Email'),

                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'poppins',
                            fontSize: 13,
                          )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textWidget('Password'),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Enter Password',

                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'poppins',
                              fontSize: 13,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                side: const BorderSide( // Set border color
                                  color: Colors.grey,
                                  width: 2, // Border thickness
                                ),
                                value: isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isChecked = newValue!;
                                  });
                                },
                              ),
                              const Text("Remember me", style: TextStyle( fontFamily: 'poppins', color: Colors.grey),),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){},
                            child: textWidget('Forgot Password ?'),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          signIn(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.pink,
                                Colors.orangeAccent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?  ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => JobCategory()),
                              );
                            },
                            child: textWidget('Sign up'),
                          )
                        ],
                      ),

                    ],
                    
                  ),
                ),
              ),


            ),
          ),
        ],
      ),
    );
  }
  Widget textWidget(String text){
    return Text(
      text,
      style: TextStyle(
        color: Colors.pinkAccent,
        fontFamily: 'poppins',
        fontSize: 13,
      ),
    );
  }
}