import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_flutter_app/providers/launch_provider.dart';
import 'package:spacex_flutter_app/models/launch.dart';

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
    return Padding(
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
    );
  }
}
