import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_flutter_app/providers/launch_provider.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/utils/date_formatter.dart';
import 'package:spacex_flutter_app/widgets/error_message.dart';

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
        error: (err, stack) => ErrorMessageWidget(
          message:
              'Failed to load launch details. Please check your connection or try again later.',
          onRetry: () {
            ref.invalidate(singleLaunchProvider(launchId));
          },
        ),
      ),
    );
  }

  Widget _buildLaunchDetails(Launch launch) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            // Widget for displaying the mission patch image
            _patchImage(launch.missionPatch),

            const SizedBox(height: 16),

            // Widget for displaying the mission title
            _launchTitle(launch.missionName),

            const SizedBox(height: 8),

            // Widget for displaying the launch date & time
            _launchDetailText(
                'Date & Time:', formatDateTime(launch.launchDate)),

            const SizedBox(height: 8),

            // Widget for displaying the success/failure status
            _launchStatus(launch.success),

            const SizedBox(height: 8),

            // Widget for displaying additional launch details
            _launchDetailText(
                'Details:', launch.details ?? 'No additional information'),
          ],
        ),
      ),
    );
  }

  Widget _patchImage(String? missionPatch) {
    return SizedBox(
      child: missionPatch != null && missionPatch.isNotEmpty
          ? Image.network(
              missionPatch,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image,
                    size: 100, color: Colors.grey);
              },
            )
          : const Icon(Icons.rocket_launch, size: 100, color: Colors.grey),
    );
  }

  Widget _launchTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _launchStatus(bool? success) {
    return Text(
      'Status: ${success == true ? 'Success' : 'Failure'}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: success == true ? Colors.green : Colors.red,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _launchDetailText(String label, String value) {
    return Text(
      '$label $value',
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}
