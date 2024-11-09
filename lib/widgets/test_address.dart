import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddressMapScreen extends StatefulWidget {
  @override
  _AddressMapScreenState createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> {
  LatLng? coordinates;
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  Future<void> _getCoordinates() async {
    final address = addressController.text;
    final apiKey = 'YOUR_OPENCAGE_API_KEY';
    final url = Uri.parse('https://api.opencagedata.com/geocode/v1/json?q=$address&key=$apiKey');

    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final lat = data['results'][0]['geometry']['lat'];
          final lng = data['results'][0]['geometry']['lng'];
          setState(() {
            coordinates = LatLng(lat, lng);
          });
        } else {
          _showError("Address not found. Please try a more specific address.");
        }
      } else {
        _showError("Failed to connect to the geocoding service.");
      }
    } catch (e) {
      print("Failed to get coordinates: $e");
      _showError("Error occurred. Please try again.");
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Address on Map")),
      body: Column(
        children: [
          // Address Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Enter Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _getCoordinates, // Search address when clicked
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : coordinates == null
                ? Center(child: Text("Enter an address to see it on the map"))
                : FlutterMap(
              options: MapOptions(
                center: coordinates ?? LatLng(47.9185, 106.9170), // Fallback to Ulaanbaatar
                zoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: coordinates!,
                      builder: (ctx) => Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
