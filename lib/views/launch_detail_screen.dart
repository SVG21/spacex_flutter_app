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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Widget for Mission Patch Image
              _patchImage(launch.missionPatch),
              const SizedBox(height: 20),
              // Widget for Launch Title
              _launchTitle(launch.missionName),
              const SizedBox(height: 12),
              // Widget for Launch Date and Time
              _launchDetailText(
                'Date & Time:',
                formatDateTime(
                  launch.launchDate,
                ),
              ),
              const SizedBox(height: 10),
              // Widget for Launch Status (Success/Failure)
              _launchStatus(launch.success),
              const SizedBox(height: 10),
              // Widget for Generic Text Information
              _launchDetailText(
                'Details:',
                launch.details ?? 'No additional information',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _patchImage(String? missionPatch) {
    if (missionPatch != null && missionPatch.isNotEmpty) {
      return Image.network(
        missionPatch,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
        },
      );
    } else {
      return const Icon(Icons.rocket_launch, size: 100, color: Colors.grey);
    }
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
