import 'package:feastfolio/jobscreated.dart';
import 'package:feastfolio/responses.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Employerhome extends StatefulWidget {
  const Employerhome({super.key});

  @override
  State<Employerhome> createState() => _EmployerhomeState();
}

class _EmployerhomeState extends State<Employerhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
                )
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi,  Tinku’s',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'notosans'
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text(
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
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
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
                            prefixIcon: Icon(IconlyLight.search, color: Colors.grey,size: 20,),
                            filled: true,
                            fillColor: Colors.white,

                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            IconlyLight.notification,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobsCreatedScreen()),
                );
              },
                child: homeWidgets(IconlyBold.edit, 'Jobs Created', '140 Jobs', Colors.blueAccent.withOpacity(0.2) , Colors.green.withOpacity(0.3))
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Responses()),
                );
              },
                child: homeWidgets(IconlyBold.show, 'Responses', '85 Jobs', Colors.greenAccent.withOpacity(0.2) , Colors.pinkAccent.withOpacity(0.3))
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            // )
          ],
        ),
      ),
    );
  }
  Widget homeWidgets(IconData IconD, String title, String job_numbers , Color color , Color Iconcolor){
    return  Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: color,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(IconD , color: Iconcolor, size: 30,),
          SizedBox(height: 8,),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'notosans',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8,),
          Text(
            job_numbers,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'notosans',
              fontSize: 13,
            ),
            
          )

        ],
      ),
    );
  }
}
