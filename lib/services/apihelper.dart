import 'dart:convert';
import 'package:movieapp/model/trendingmovie.dart';
import 'package:http/http.dart' show Client, Response;

class ApiHelper {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'c9f41c68f12e06fc1cf9c62fc023f453';

  Client client = Client();

  Future<TrendingMovies> getTrendingMovies() async {
    Response response = await client
        .get(Uri.parse('$baseUrl/trending/all/day?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return TrendingMovies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}
