import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_community_feed_app/models/post_model.dart';
import 'package:mini_community_feed_app/utils/utils.dart';

// Service class to handle API requests
class ApiService {
  Future<List<PostModel>> fetchPosts() async {
    // Constructing the URI from the constant URL
    Uri uri = Uri.parse(HttpConstants.postsURL);

    try {
      //Fetching data from the API
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
