import 'package:feastfolio/orangebutton.dart';
import 'package:feastfolio/yellowbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/jobs_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addjobs extends ConsumerStatefulWidget {
  const Addjobs({super.key});

  @override
  ConsumerState<Addjobs> createState() => _AddjobsState();
}

class _AddjobsState extends ConsumerState<Addjobs> {
  String? jobPosition;
  String? workplaceType;
  String? employmentType;
  String? jobLocation;
  String? company;
  String? description;
  int? salary;
  int? vacancies;
  int? experience;

  void createJobs(BuildContext context) async {
    final jobsController = ref.read(jobsControllerProvider);


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Posting job...")),
    );

    final error = await jobsController.createJob(
      jobPosition: jobPosition!,
      workplaceType: workplaceType!,
      employmentType: employmentType!,
      location: jobLocation!,
      company: company!,
      description: description!,
      salary: salary!,
      vacancies: vacancies!,
      experience : experience!,
    );


    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (error != null) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Job posted successfully!")),
      );

      // Clear the form
      setState(() {
        jobPosition = null;
        workplaceType = null;
        employmentType = null;
        jobLocation = null;
        company = null;
        description = null;
        salary = null;
        vacancies = null;
        experience = null;
      });
    }
  }



  void _showBottomSheetRadio({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    fontSize: 16,
                  ),
                ),
                const Divider(),
                ...options.map(
                      (option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      onSelected(value!);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetText({
    required String title,
    required String? initialValue,
    required Function(String) onSaved,
  }) {
    final controller = TextEditingController(text: initialValue);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter here',

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow, width: 2.0), // Color when focused
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // ElevatedButton(
              //   onPressed: () {
              //     onSaved(controller.text.trim());
              //     Navigator.pop(context);
              //   },
              //   child: const Text("Save"),
              // ),
              GestureDetector(
                onTap: (){
                  onSaved(controller.text.trim());
                  Navigator.pop(context);
                },
                child: Yellowbutton(text: 'Save'),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(String title, String? value, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
                if (value != null && value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          (value != null && value.isNotEmpty)?
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.edit,
              color: Colors.orangeAccent[100],
            ),
          )
              :
              IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.orangeAccent[100],
                  ),
              )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a Job',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard("Job Position", jobPosition, () {
              _showBottomSheetRadio(
                title: "Select Job Position",
                options: ["Assistant", "Associate", "Administrative Assistant", "Chef", "Waiter", "Manager", "Junior chef","Junior Waiter"],
                selectedValue: jobPosition,
                onSelected: (val) => setState(() => jobPosition = val),
              );
            }),
            _buildCard("Type of Workplace", workplaceType, () {
              _showBottomSheetRadio(
                title: "Select Workplace Type",
                options: ["On-site", "Remote", "Hybrid"],
                selectedValue: workplaceType,
                onSelected: (val) => setState(() => workplaceType = val),
              );
            }),
            _buildCard("Employment Type", employmentType, () {
              _showBottomSheetRadio(
                title: "Select Employment Type",
                options: ["Full-time", "Part-time", "Contract"],
                selectedValue: employmentType,
                onSelected: (val) => setState(() => employmentType = val),
              );
            }),
            _buildCard("Job Location", jobLocation, () {
              _showBottomSheetText(
                title: "Enter Job Location",
                initialValue: jobLocation,
                onSaved: (val) => setState(() => jobLocation = val),
              );
            }),
            _buildCard("Company", company, () {
              _showBottomSheetText(
                title: "Enter Company Name",
                initialValue: company,
                onSaved: (val) => setState(() => company = val),
              );
            }),
            _buildCard("Description", description, () {
              _showBottomSheetText(
                title: "Enter Job Description",
                initialValue: description,
                onSaved: (val) => setState(() => description = val),
              );
            }),
            _buildCard("Salary (INR)", salary?.toString(), () {
              _showBottomSheetText(
                title: "Enter Salary",
                initialValue: salary?.toString(),
                onSaved: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    setState(() => salary = parsed);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid number for salary.")),
                    );
                  }
                },
              );
            }),
            _buildCard("Vacancies", vacancies?.toString(), () {
              _showBottomSheetText(
                title: "Enter Number of Vacancies",
                initialValue: vacancies?.toString(),
                onSaved: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    setState(() => vacancies = parsed);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid number for vacancies.")),
                    );
                  }
                },
              );
            }),
            _buildCard("experience", experience?.toString(), () {
              _showBottomSheetText(
                title: "Enter minimum experience required (in years)",
                initialValue: experience?.toString(),
                onSaved: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    setState(() => experience = parsed);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid experience.")),
                    );
                  }
                },
              );
            }),

            GestureDetector(
              onTap: (){
                createJobs(context);
              },
              child: Yellowbutton(text: 'Post Jobs'),
            )
          ],
        ),
      ),
    );
  }
}
