import 'package:flutter/material.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/views/launch_detail_screen.dart';
import 'package:spacex_flutter_app/utils/date_formatter.dart';

// Card Widget to show launch list
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatDateTime(launch.launchDate),
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            launch.success == true ? 'Success' : 'Failure',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: launch.success == true
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ],
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
