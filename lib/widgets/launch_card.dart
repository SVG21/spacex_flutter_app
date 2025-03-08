import 'package:flutter/material.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/views/launch_detail_screen.dart';
import 'package:spacex_flutter_app/utils/date_formatter.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () {
        // Navigate to the launch detail screen when the list item is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LaunchDetailScreen(launchId: launch.id),
          ),
        );
      },
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display mission patch if available, otherwise show a default icon
          SizedBox(
            width: 50,
            height: 50,
            child: launch.missionPatch != null &&
                    launch.missionPatch!.isNotEmpty
                ? Image.network(
                    launch.missionPatch!,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.rocket_launch, size: 30, color: Colors.grey),
          ),
          const SizedBox(width: 8), // Spacing between image and text

          // Expanded widget ensures text does not overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display mission name
                Text(
                  launch.missionName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),

                // Display formatted launch date
                Text(
                  formatDateTime(launch.launchDate),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),

                // Display launch status with color coding for success/failure
                Text(
                  launch.success == true ? 'Success' : 'Failure',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: launch.success == true ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
