import 'dart:ffi';

import 'package:feastfolio/jobapply.dart';
import 'package:flutter/material.dart';

class Restaurantjobtile extends StatefulWidget {
  final String imageUrl;
  final String jobTitle;
  final int salary;
  final String location;
  final String restaurantName;
  final String description;
  final String jobtype;
  final int experience;
  final String id;
  final String postedBy;
  const Restaurantjobtile({
    Key? key,
    required this.imageUrl,
    required this.jobTitle,
    required this.salary,
    required this.location,
    required this.restaurantName,
    required this.description,
    required this.jobtype,
    required this.experience,
    required this.id,
    required this.postedBy,
  }) : super(key: key);

  @override
  State<Restaurantjobtile> createState() => _RestaurantjobtileState();
}

class _RestaurantjobtileState extends State<Restaurantjobtile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
          width: 2
        )
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounds all corners
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // optional placeholder background
                  ),
                  child: Image.asset(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.jobTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'notosans',
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    widget.location,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'notosans',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '₹ '+widget.salary.toString() +'/Yearly',
                    style: TextStyle(
                      color: Colors.orange,
                      fontFamily: 'notosans',
                      fontSize: 12,
                    ),
                  ),

                ],
              )

            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jobapply(imageUrl: widget.imageUrl, jobTitle: widget.jobTitle, salary: widget.salary, location: widget.location, restaurantName: widget.restaurantName , description: widget.description,jobtype: widget.jobtype, experience: widget.experience,id: widget.id, postedBy: widget.postedBy,)),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  )
                ),
                child: Text(
                  'Read More',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'signika',
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
