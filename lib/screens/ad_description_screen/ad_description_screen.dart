import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDescriptionScreen extends StatelessWidget {
  final String adId;
  final String userName;
  final String profilePic;
  final String address;
  final String details;
  final String price;
  final String date;
  final String shift;
  final int views;
  final int requestCount;
  final String phoneNumber;

  const AdDescriptionScreen({
    required this.adId,
    required this.userName,
    required this.profilePic,
    required this.address,
    required this.details,
    required this.price,
    required this.date,
    required this.shift,
    required this.views,
    required this.requestCount,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010536),
      // Dark blue background
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Back Arrow at the top left
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Navigates back to the previous screen
                },
              ),
            ),

            // White Rectangle positioned to overlap with the profile picture
            Positioned(
              top: 100, // Adjust to control the overlap
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: 40), // Adjust to show content below the profile picture
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Address Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            address,
                          ),
                          Icon(Icons.location_pin, color: Color(0xFFFE5009)
                          ,),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Price and Shift Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4, // Adjust the width as needed
                            child: _buildInfoCard(Icons.attach_money, 'Үнэ / Хөлс', price),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4, // Adjust the width as needed
                            child: _buildInfoCard(Icons.access_time, 'Хугацаа', shift),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Date, Views, and Request Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Огноо: $date',
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          Row(
                            children: [
                              Icon(Icons.visibility, color: Colors.grey),
                              SizedBox(width: 4),
                              Text('$views', style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.group, color: Colors.grey),
                              SizedBox(width: 4),
                              Text('Хүсэлт: $requestCount', style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Details
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Дэлгэрэнгүй',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        details,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),
                      // Tags
                      Wrap(
                        spacing: 12.0,
                        children: [
                          _buildTag("Туршлагатай"),
                          _buildTag("Бүтэн цаг"),
                          _buildTag("Маргааш"),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildActionButton(
                            context,
                            label: 'Хүсэлт илгээх',
                            color: Color.fromRGBO(128, 0, 0, 1),
                            onPressed: () {
                              // Handle send request, using adId if needed
                            },
                          ),
                          _buildActionButton(
                            context,
                            label: 'Холбоо барих',
                            color: Color(0xFF010536),
                            onPressed: () {
                              _launchPhoneDialer(phoneNumber);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Profile Picture and Username above the White Rectangle
            Positioned(
              top: 20, // Position profile picture
              child: Column(
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(3), // Padding for the border width
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3), // White border
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxSycPmZ67xN1lxHxyMYOUPxZObOxnkLf6w&s',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the info card
  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper widget to build a tag
  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper widget to build an action button
  Widget _buildActionButton(BuildContext context, {required String label, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }

  // Function to launch the phone dialer
  Future<void> _launchPhoneDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
