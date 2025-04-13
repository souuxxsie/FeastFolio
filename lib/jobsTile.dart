import 'package:feastfolio/restaurantjobscreen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Jobstile extends StatefulWidget {
  final String imageUrl;
  final String restaurantName;
  final String location;
  final double rating;
  final int jobsCount;
  final String uid;

  const Jobstile({
    Key? key,
    required this.imageUrl,
    required this.restaurantName,
    required this.location,
    required this.rating,
    required this.jobsCount,
    required this.uid,
  }) : super(key: key);

  @override
  State<Jobstile> createState() => _JobstileState();
}

class _JobstileState extends State<Jobstile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Restaurantjobscreen(imageUrl: widget.imageUrl , restaurantName: widget.restaurantName , rating: widget.rating , location: widget.location, uid: widget.uid),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              child: Image.asset(
                widget.imageUrl,
                width: double.infinity,
                height: 175,
                fit: BoxFit.cover,
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restaurantName,
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'signika'
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(
                              IconlyBold.location,
                              color: Colors.pink[200],
                              size: 30,
                            ),
                            Expanded(
                              child: Text(
                                widget.location,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepOrangeAccent,
                              Colors.orangeAccent,

                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.rating.toString(),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 3,),
                            Icon(
                              IconlyBold.star,
                              color: Colors.white,
                              size: 11,
                            )
                          ],
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.jobsCount.toString() + ' Active jobs',
                          style: TextStyle(
                            fontFamily: 'signika',
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
