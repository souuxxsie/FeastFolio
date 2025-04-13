import 'package:feastfolio/employeehomescreen.dart';
import 'package:feastfolio/employerhomescreen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobCategory extends ConsumerStatefulWidget {
  const JobCategory({super.key});

  @override
  ConsumerState<JobCategory> createState() => _JobCategoryState();
}

class _JobCategoryState extends ConsumerState<JobCategory> {

  final uid = FirebaseAuth.instance.currentUser?.uid;

  void setUserType(String type, Widget nextScreen) async {
    if (uid != null) {
      await ref.read(authControllerProvider).updateUserType(uid!, type);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usertype "$type" saved!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 75, bottom: 20),
              child: Center(
                child: Icon(
                  IconlyBroken.search,
                  size: MediaQuery.of(context).size.height/4,
                  color: Colors.orangeAccent.withOpacity(0.6),
                ),
              ),
            ),
            Text(
              'Select a Job Category',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'poppins',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                textAlign: TextAlign.center,
                'Select whether you’re seeking employment opportunities or your organization requires talented individuals.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setUserType('employee', Employeehomescreen());
                  },
                  child: Container(

                    height: 245,
                    width: 135,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.orange,
                        width: 1,
                      ),
                    ),
                    child: Column(

                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        ClipOval(
                          child: Container(

                            height: 108,
                            width: 108,
                            color: Colors.orange.withOpacity(0.2),
                            child: Center(
                              child: Icon(
                                IconlyBold.star,
                                size: 40,
                                color: Colors.orangeAccent[100],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Find a Job',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setUserType('employer', EmployerHomeScreen());
                  },
                  child: Container(

                    height: 245,
                    width: 135,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: Column(

                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        ClipOval(
                          child: Container(

                            height: 108,
                            width: 108,
                            color: Colors.blue.withOpacity(0.2),
                            child: Center(
                              child: Icon(
                                IconlyBold.wallet,
                                size: 40,
                                color: Colors.blueAccent[100],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Find an employee',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
