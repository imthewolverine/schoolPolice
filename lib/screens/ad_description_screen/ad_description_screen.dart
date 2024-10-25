import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ad_description_bloc.dart';
import 'ad_description_event.dart';
import 'ad_description_state.dart';
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
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Description'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to home screen
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (_) => AdDescriptionBloc(),
        child: BlocConsumer<AdDescriptionBloc, AdDescriptionState>(
          listener: (context, state) {
            if (state is JobRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Job request sent successfully!')),
              );
            } else if (state is JobRequestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to profile
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profilePic),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      userName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Address: $address'),
                    SizedBox(height: 8),
                    Text('Details: $details'),
                    SizedBox(height: 8),
                    Text('Price: $price'),
                    SizedBox(height: 8),
                    Text('Date: $date'),
                    SizedBox(height: 8),
                    Text('Shift: $shift'),
                    SizedBox(height: 8),
                    Text('Views: $views'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AdDescriptionBloc>().add(SubmitJobRequest(adId));
                      },
                      child: (state is JobRequestLoading)
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Submit Job Request'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _launchPhoneDialer(phoneNumber);
                      },
                      child: Text('Contact'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

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
