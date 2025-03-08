import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_flutter_app/providers/launch_provider.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/utils/date_formatter.dart';

class LaunchDetailScreen extends ConsumerWidget {
  final String launchId;

  const LaunchDetailScreen({super.key, required this.launchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchAsyncValue = ref.watch(singleLaunchProvider(launchId));

    return Scaffold(
      appBar: AppBar(title: const Text('Launch Details')),
      body: launchAsyncValue.when(
        data: (launch) => _buildLaunchDetails(launch),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildLaunchDetails(Launch launch) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (launch.missionPatch != null)
              Image.network(
                launch.missionPatch!,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 20),
            Text(
              launch.missionName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Date & Time: ${formatDateTime(launch.launchDate)}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${launch.success == true ? 'Success' : 'Failure'}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: launch.success == true
                    ? Colors.green
                    : Colors.red, // Color based on status
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Details:\n${launch.details ?? 'No additional information'}',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
