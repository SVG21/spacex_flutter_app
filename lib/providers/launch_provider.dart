import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_flutter_app/models/launch.dart';
import 'package:spacex_flutter_app/services/spacex_service.dart';

final spaceXServiceProvider = Provider((ref) => SpaceXService());

final launchesProvider = FutureProvider<List<Launch>>((ref) async {
  final service = ref.read(spaceXServiceProvider);
  return await service.fetchLaunches();
});

final selectedYearProvider = StateProvider<int?>((ref) => null);

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

final singleLaunchProvider = FutureProvider.family<Launch, String>((ref, id) async {
  final service = ref.read(spaceXServiceProvider);
  return await service.fetchLaunchById(id);
});


