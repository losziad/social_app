import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String batteryLevel = 'Unknown battery level.';
  Future<void> getBatteryLevel() async
  {
   String batteryLevel;
   try{
     final int result = await platform.invokeMethod('getBatteryLevel');
     batteryLevel = 'Battery level at $result % .';
   } on PlatformException catch (e){
     batteryLevel = 'Falied to get battery level: ${e.message} .';
   }

   setState(() {
     batteryLevel = batteryLevel;
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
                child: Text('Get Battery Level'),
            ),
             Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
