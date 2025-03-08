import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_flutter_app/providers/launch_provider.dart';
import 'package:spacex_flutter_app/widgets/error_message.dart';
import 'package:spacex_flutter_app/widgets/launch_card.dart';

class LaunchListScreen extends ConsumerWidget {
  const LaunchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchesAsyncValue = ref.watch(filteredLaunchesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('SpaceX Launches')),
      body: Column(
        children: [
          _filterDropdown(ref),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => ref.refresh(launchesProvider),
              child: launchesAsyncValue.when(
                data: (launches) => _launchListView(launches),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => ErrorMessageWidget(
                  message:
                      'Failed to load data. Please check your connection or try again later.',
                  onRetry: () => ref
                      .invalidate(filteredLaunchesProvider), // Force a refresh
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function-based Filter Dropdown
Widget _filterDropdown(WidgetRef ref) {
  final years = List.generate(10, (index) => DateTime.now().year - index);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButton<int>(
      hint: const Text("Filter by Year"),
      value: ref.watch(selectedYearProvider),
      items: years.map((year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text(year.toString()),
        );
      }).toList(),
      onChanged: (year) {
        ref.read(selectedYearProvider.notifier).state = year;
      },
    ),
  );
}

// Widget for launch list
Widget _launchListView(List<dynamic> launches) {
  if (launches.isEmpty) {
    return const Center(
      child: Text(
        'No launches found for this year.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
  return ListView.builder(
    itemCount: launches.length,
    itemBuilder: (context, index) {
      final launch = launches[index];
      return LaunchCard(launch: launch);
    },
  );
}
