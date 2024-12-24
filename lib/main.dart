import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeviceMessageScreen(),
    );
  }
}

class DeviceMessageScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DeviceMessageScreenState createState() => _DeviceMessageScreenState();
}

class _DeviceMessageScreenState extends State<DeviceMessageScreen> {
  String _deviceInfo = 'Unknown';
  String _connectivityStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
    _getConnectivityStatus();
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var androidInfo = await deviceInfo.androidInfo;

    setState(() {
      _deviceInfo = 'Android Device: ${androidInfo.model}';
    });
  }

  Future<void> _getConnectivityStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    setState(() {
      if (connectivityResult == ConnectivityResult.mobile) {
        _connectivityStatus = 'Connected to Mobile Network';
      } else if (connectivityResult == ConnectivityResult.wifi) {
        _connectivityStatus = 'Connected to WiFi';
      } else {
        _connectivityStatus = 'No Internet Connection';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Messages'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Device Info: $_deviceInfo'),
            Text('Connectivity Status: $_connectivityStatus'),
          ],
        ),
      ),
    );
  }
}