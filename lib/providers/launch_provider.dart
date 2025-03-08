import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/services/spacex_service.dart';


// Provides an instance of `SpaceXService` for API calls
final spaceXServiceProvider = Provider((ref) => SpaceXService());

// Fetches all launches from SpaceX API
final launchesProvider = FutureProvider<List<Launch>>((ref) async {
  final service = ref.read(spaceXServiceProvider);
  return await service.fetchLaunches();
});

// Holds the selected year for filtering launches
final selectedYearProvider = StateProvider<int?>((ref) => null);

// Fetches launches filtered by the selected year
final filteredLaunchesProvider = FutureProvider<List<Launch>>((ref) async {
  final service = ref.read(spaceXServiceProvider);
  final launches = await service.fetchLaunches();
  final selectedYear = ref.watch(selectedYearProvider);
  return selectedYear != null
      ? launches
          .where((launch) => launch.launchDate.year == selectedYear)
          .toList()
      : launches;
});

// Fetches details of a specific launch by ID
final singleLaunchProvider =
    FutureProvider.family<Launch, String>((ref, id) async {
  final service = ref.read(spaceXServiceProvider);
  return await service.fetchLaunchById(id);
});
