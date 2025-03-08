import 'package:flutter/material.dart';
import 'package:spacex_flutter_app/models/launch.dart';

class LaunchDetailScreen extends StatelessWidget {
  final Launch launch;
  const LaunchDetailScreen({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(launch.missionName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (launch.missionPatch != null)
              Image.network(launch.missionPatch!, height: 200),
            const SizedBox(height: 16),
            Text('Mission: ${launch.missionName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Date: ${launch.launchDate.toLocal()}'),
            const SizedBox(height: 8),
            Text('Status: ${launch.success == true ? 'Success' : 'Failure'}'),
            const SizedBox(height: 8),
            Text('Details: ${launch.details ?? 'No additional information'}'),
          ],
        ),
      ),
    );
  }
}
