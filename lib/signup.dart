import 'package:feastfolio/jobcategory.dart';
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});



  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();


  void signUp(BuildContext context) async {
    final authController = ref.read(authControllerProvider);
    final message = await authController.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
    );

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup successful!')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobCategory()),
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
                "assets/images/sapiens.png", // Replace with your image path
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
                      textWidget('Name'),

                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: 'Enter your name',
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
                      textWidget('Phone No.'),

                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            hintText: 'Enter your number',
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


                      GestureDetector(
                        onTap: (){
                          signUp(context);
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
                              'Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
