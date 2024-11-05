import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'time_record_bloc.dart';
import 'time_record_event.dart';
import 'time_record_state.dart';

class TimeRecordScreen extends StatefulWidget {
  final String adId;

  const TimeRecordScreen({Key? key, required this.adId}) : super(key: key);

  @override
  _TimeRecordScreenState createState() => _TimeRecordScreenState();
}

class _TimeRecordScreenState extends State<TimeRecordScreen> {
  final Location _location = Location();
  bool _isArrived = false;
  bool _isDeparted = false;
  String _arrivalTimeText = "00:00";
  String _departureTimeText = "00:00";
  String _totalWorkedTimeText = "00:00";
  late DateTime _arrivalTime;
  late DateTime _departureTime;
  LatLng _adLocation = LatLng(47.920355462040476, 106.9279488799336); // Ad location
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _listenToLocationChanges();
  }

  void _listenToLocationChanges() async {
    _location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
      });
    });
  }

  void _checkArrival() async {
    if (_isArrived) return;

    if (_userLocation == null) return;

    final Distance distance = Distance();
    double distanceInMeters = distance.as(LengthUnit.Meter, _userLocation!, _adLocation);

    if (distanceInMeters <= 700) {
      setState(() {
        _isArrived = true;
        _arrivalTime = DateTime.now();
        _arrivalTimeText = "${_arrivalTime.hour}:${_arrivalTime.minute}";
      });

      BlocProvider.of<TimeRecordBloc>(context).add(ArriveEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You are not within 700 meters of the location.")),
      );
    }
  }

  void _checkDeparture() async {
    if (!_isArrived || _isDeparted) return;

    final Distance distance = Distance();
    double distanceInMeters = distance.as(LengthUnit.Meter, _userLocation!, _adLocation);

    if (distanceInMeters <= 700) {
      setState(() {
        _isDeparted = true;
        _departureTime = DateTime.now();
        _departureTimeText = "${_departureTime.hour}:${_departureTime.minute}";

        final workedDuration = _departureTime.difference(_arrivalTime);
        _totalWorkedTimeText = "${workedDuration.inHours}ц ${workedDuration.inMinutes.remainder(60)}мин";
      });

      BlocProvider.of<TimeRecordBloc>(context).add(DepartEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You are not within 700 meters of the location.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => TimeRecordBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          title: Text("Time Record", style: textTheme.headlineSmall?.copyWith(
    color: Theme.of(context).colorScheme.onPrimary, // Set color within TextStyle
    )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            // Timer Display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(_arrivalTimeText, style: textTheme.titleMedium?.copyWith(color: Colors.black)),
                  ],
                ),
              ),
            ),

            // Map Section
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlutterMap(
                        options: MapOptions(
                          center: _userLocation ?? _adLocation,
                          zoom: 15.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          CircleLayer(
                            circles: [
                              CircleMarker(
                                point: _adLocation,
                                color: Colors.blue.withOpacity(0.3),
                                borderStrokeWidth: 2,
                                borderColor: Colors.blue,
                                radius: 100, // Fixed radius in meters
                              ),
                            ],
                          ),
                          if (_userLocation != null)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 30.0,
                                  height: 30.0,
                                  point: _userLocation!,
                                  builder: (ctx) => Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 30.0,
                                height: 30.0,
                                point: _adLocation,
                                builder: (ctx) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Information Row and Buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              color: Colors.white,
              child: Column(
                children: [
                  // Time Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTimeInfo(_arrivalTimeText, "Ирсэн", textTheme),
                      _buildTimeInfo(_departureTimeText, "Явсан", textTheme),
                      _buildTimeInfo("00:03", "Хоцорсон", textTheme),
                      _buildTimeInfo(_totalWorkedTimeText, "Нийт", textTheme),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Action Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                          minimumSize: Size(180, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isArrived ? null : _checkArrival,
                        child: Text("Ирлээ", style: textTheme.labelLarge?.copyWith(color: Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          minimumSize: Size(180, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isDeparted ? null : _checkDeparture,
                        child: Text("Явлаа", style: textTheme.labelLarge?.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String time, String label, TextTheme textTheme) {
    return Column(
      children: [
        Text(time, style: textTheme.titleMedium),
        Text(label, style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
      ],
    );
  }
}
