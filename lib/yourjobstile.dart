import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YourJobsTile extends StatefulWidget {
  final String imageUrl;
  final String restaurantName;
  final String jobtitle;
  final String status;
  final DateTime dateTime;

  const YourJobsTile({
    Key? key,
    required this.imageUrl,
    required this.restaurantName,
    required this.jobtitle,
    required this.status,
    required this.dateTime,
  }) : super(key: key);

  @override
  State<YourJobsTile> createState() => _YourJobsTileState();
}

class _YourJobsTileState extends State<YourJobsTile> {
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ColoredBox(
                    color: Color.fromRGBO(255, 132, 175, 1.0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Your application for ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: widget.jobtitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: Color.fromRGBO(27, 27, 140, 1.0),
                            ),
                          ),
                          const TextSpan(
                            text: ' at ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: widget.restaurantName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: Color.fromRGBO(27, 27, 140, 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to Job
                      },
                      child: const Text(
                        'View Job',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'poppins',
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              widget.status,
              style: TextStyle(
                color: _getStatusColor(widget.status),
                fontFamily: 'poppins',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
