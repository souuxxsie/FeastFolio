import 'package:feastfolio/orangebutton.dart';
import 'package:feastfolio/orangeheading.dart';
import 'package:feastfolio/orangeroundedtag.dart';
import 'package:feastfolio/signikatext.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../controllers/jobApplicationController.dart';
import '../providers/jobApplicationControllerProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Jobapply extends ConsumerStatefulWidget {
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
  const Jobapply({
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
    required this.postedBy
  }) : super(key: key);

  @override
  ConsumerState<Jobapply> createState() => _JobapplyState();
}

class _JobapplyState extends ConsumerState<Jobapply> {
  bool isLoading = false;

  void _applyToJob() async {
    setState(() {
      isLoading = true;
    });

    final controller = ref.read(jobApplicationControllerProvider);
    final result = await controller.applyForJob(
      jobId: widget.id,

    );
    ref.invalidate( hasUserAppliedProvider(widget.id));
    setState(() {
      isLoading = false;
    });


    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application submitted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasApplied = ref.watch(hasUserAppliedProvider(widget.id));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),

                ),

                gradient: LinearGradient(
                  colors: [
                    // Color.fromRGBO(15, 17, 59, 1.0),

                    Color.fromRGBO(255, 77, 0, 1.0),
                    Color.fromRGBO(255, 192, 103, 1.0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                ),
                image: DecorationImage(
                  image: AssetImage(widget.imageUrl),
                  opacity: 0.3,
                  fit: BoxFit.cover,
                )
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.jobtype,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'signika',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          widget.jobTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'signika',
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.white,
                            ),
                           SizedBox(width: 10,),
                            Text(
                              '₹'+widget.salary.toString(),
                              style: TextStyle(
                                fontFamily: 'signika',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),


                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Icon(
                              IconlyBold.location,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              widget.location,
                              style: TextStyle(
                                fontFamily: 'signika',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),


                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Icon(
                              IconlyBold.work,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              widget.experience.toString() + ' Years',
                              style: TextStyle(
                                fontFamily: 'signika',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),


                          ],
                        )


                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Icon(
                      IconlyBold.bookmark,
                      size: 35,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Orangeheading(text: 'Job Description'),
                    SizedBox(height: 5,),
                    Signikatext(
                        text: widget.description,
                        fontsize: 15,
                    ),
                    SizedBox(height: 5,),
                    // Orangeheading(text: 'Skills Required'),
                    // SizedBox(height: 5,),
                    // Wrap(
                    //   spacing: 10, // space between items
                    //   runSpacing: 10, // space between lines
                    //   children: [
                    //     Orangeroundedtag(text: 'Cooking'),
                    //     Orangeroundedtag(text: 'intercontinental'),
                    //     Orangeroundedtag(text: 'Thai'),
                    //     Orangeroundedtag(text: 'Asian'),
                    //     Orangeroundedtag(text: 'Fishing and Hunting'),
                    //     Orangeroundedtag(text: 'Vocabulary'),
                    //   ],
                    // ),
                    // SizedBox(height: 8,),
                    Orangeheading(text: 'About ${widget.restaurantName}'),
                    Signikatext(
                        text: 'jnjs isdo dsuhdoi udhdjiods hdhiuass d asidasuidh asishsiuass d uhdoudshd sid  iusddh sid hc ciy sdygh sidydhdiy sddiu dsdhdsiyd sdhh dikydsyksd dihsddihhdshihis  sdc hsdihd isdhdihds ysd ch sc ciudsh iyh dsdiydhdsi hdiydshdu dou isdh disddiuhdsiudhuoh susds  oudshdouds dsuhjds jchcdsui hcii hciud hcicciu cih dfy cdhhi cug cyui idsy ch sdhu sdu hch sdc bdh cdi uch dui csdh ciscih sdi hcids ch dh bch ccih dsih c bidci dih ci hc bic bic bdib cij ',
                        fontsize: 15,
                    ),
                    SizedBox(height: 8,),



                    hasApplied.when(
                      data:(applied){
                        if(applied){
                          return Container(
                              child: Center(child: Orangebutton(text: 'Applied'))
                          );
                        }
                        else{
                          return GestureDetector(
                            onTap: _applyToJob,
                            child:
                            (isLoading)?
                            Container(
                                child: Center(child: Orangebutton(text: 'Applying...'))
                            )
                                :
                            Container(
                                child: Center(child: Orangebutton(text: 'Apply'))
                            ),
                          );
                        }
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (e, _) => Text('Error checking application'),
                    )


                  ],
                ),
              ),
            )

          ],


        ),
      )
    );
  }
}
