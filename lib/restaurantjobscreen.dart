import 'package:feastfolio/restaurantjobtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import '../providers/jobs_provider.dart';
import '../controllers/jobs_controller.dart';

class Restaurantjobscreen extends ConsumerStatefulWidget {
  final String imageUrl;
  final String restaurantName;
  final String location;
  final double rating;
  final String uid;

  const Restaurantjobscreen({
    Key? key,
    required this.imageUrl,
    required this.restaurantName,
    required this.location,
    required this.rating,
    required this.uid,
  }) : super(key: key);

  @override
  ConsumerState<Restaurantjobscreen> createState() => _RestaurantjobscreenState();
}

class _RestaurantjobscreenState extends ConsumerState<Restaurantjobscreen> {
  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobsByUidStreamProvider(widget.uid));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Half Container
            Container(

              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                    spreadRadius: 2, // How much the shadow spreads
                    blurRadius: 10, // Softness of the shadow
                    // X and Y offset (horizontal, vertical)
                  ),
                ],

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Name
                  Text(
                    widget.restaurantName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: 'signika',
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Location
                  Text(
                    widget.location,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'signika',
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Rating + Employee Friendly Container
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal:10),
                    width: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.deepOrangeAccent,
                          Colors.orangeAccent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Centered Rating Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              IconlyBold.star,
                              color: Colors.white,
                              size: 12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Centered "Employee Friendly" Text
                        const Text(
                          'Employee Friendly',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'signika',
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],

              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'All Jobs',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'signika',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


            jobs.when(
              data: (snapshot) {
                final jobDocs = snapshot.docs;

                return ListView.builder(
                  itemCount: jobDocs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final doc = jobDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Restaurantjobtile(
                      imageUrl: 'assets/images/restro.jpg',
                      jobTitle: data['jobPosition'],
                      salary: data['salary']??0,
                      location: data['location'],
                      restaurantName: data['company'],
                      description: data['description'],
                      jobtype: data['employmentType']??'N/A',
                      experience: data['experience']?? 0,
                      id: doc.id,
                      postedBy: data['postedBy'],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            )

          ],
        ),
      ),
    );
  }
}
