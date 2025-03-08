import 'package:flutter/material.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/views/launch_detail_screen.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: launch.missionPatch != null
          ? Image.network(launch.missionPatch!, width: 50, height: 50)
          : const Icon(Icons.rocket_launch),
      title: Text(launch.missionName),
      subtitle: Text(
        'Date: ${launch.launchDate.toLocal()} | Status: ${launch.success == true ? 'Success' : 'Failure'}',
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LaunchDetailScreen(launchId: launch.id),
          ),
        );
      },
    );
  }
}
