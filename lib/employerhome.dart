import 'package:feastfolio/jobscreated.dart';
import 'package:feastfolio/login.dart';
import 'package:feastfolio/responses.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/jobApplicationControllerProvider.dart';
import '../controllers/jobs_controller.dart';
import '../providers/user_provider.dart';

class Employerhome extends ConsumerStatefulWidget {
  const Employerhome({super.key});

  @override
  ConsumerState<Employerhome> createState() => _EmployerhomeState();
}

class _EmployerhomeState extends ConsumerState<Employerhome> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Not logged in'));
    }

    final uid = user.uid;
    final userAsyncValue = ref.watch(userByIdProvider(uid));
    final jobsByUser = ref.watch(jobsByUidStreamProvider(uid));
    final responsesCount = ref.watch(userRecruiterApplicationsCountProvider);


    return userAsyncValue.when(
      data: (userData) {
        final name = userData?['name'] ?? 'User';

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(24, 30, 77, 1.0),
                        Color.fromRGBO(0, 0, 0, 1.0)
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, $name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'notosans',
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: const Text(
                              'Find your dream employee here!',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'notosans',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'poppins',
                                  fontSize: 13,
                                ),
                                prefixIcon: Icon(
                                  IconlyLight.search,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          IconlyLight.notification,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Jobs Created (with job count)
                jobsByUser.when(
                  data: (snapshot) {
                    final jobCount = snapshot.docs.length;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const JobsCreatedScreen()),
                        );
                      },
                      child: homeWidgets(
                        IconlyBold.edit,
                        'Jobs Created',
                        '$jobCount Jobs',
                        Colors.blueAccent.withOpacity(0.2),
                        Colors.green.withOpacity(0.3),
                      ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
                ),

                /// Responses (static for now)
                responsesCount.when(
                  data: (responseCount) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Responses()),
                      );
                    },
                    child: homeWidgets(
                      IconlyBold.show,
                      'Responses',
                      '$responseCount Applications',
                      Colors.greenAccent.withOpacity(0.2),
                      Colors.pinkAccent.withOpacity(0.3),
                    ),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  Widget homeWidgets(
      IconData iconD, String title, String jobNumbers, Color color, Color iconColor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconD, color: iconColor, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'notosans',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            jobNumbers,
            style: const TextStyle(
              color: Colors.grey,
              fontFamily: 'notosans',
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
