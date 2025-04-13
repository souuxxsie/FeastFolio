import 'package:feastfolio/jobsTile.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/employers_provider.dart';

class Employeehome extends ConsumerStatefulWidget {
  const Employeehome({super.key});

  @override
  ConsumerState<Employeehome> createState() => _EmployeehomeState();
}

class _EmployeehomeState extends ConsumerState<Employeehome> {
  @override
  Widget build(BuildContext context) {
    final employersAsync = ref.watch(employersProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2), // Light grey border
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, // Darker border when focused
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  prefixIcon: Icon(
                    IconlyLight.search,
                    color: Colors.grey,
                    size: 18,
                  ),
                  hintText: 'Restaurant name, job type, specification...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins', // Ensure 'Poppins' is in pubspec.yaml
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),

            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: filtersButton('One day hiring'),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: filtersButton('PRO'),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: filtersButton('Regular Jobs'),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: filtersButton('Internships'),
                  )
                ],
              ),
            ),

            SizedBox(height: 10,),

            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Jobs for you',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'signika',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),

            employersAsync.when(
                data: (employers){

                  return ListView.builder(
                      itemCount: employers.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        final emp = employers[index];
                        return Jobstile(imageUrl: 'assets/images/restro.jpg', restaurantName: emp.name, location: emp.locations[0], rating: 4.5, jobsCount: emp.jobCount , uid: emp.uid,);
                      }
                  );

                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error'))
            )


          ],
        ),
      ),
    );
  }



  Widget filtersButton(String text){
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 3 , horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'poppins',
          fontSize: 10,
        ),
      ),
    );
  }
}
