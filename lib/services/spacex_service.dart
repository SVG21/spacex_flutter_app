import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex_flutter_app/models/launch.dart';

class SpaceXService {
  static const String _baseUrl = 'https://api.spacexdata.com/v5/launches';

  Future<List<Launch>> fetchLaunches() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Launch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load launches');
    }
  }
}
