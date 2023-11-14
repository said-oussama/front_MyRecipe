import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hungry/models/core/api_response.dart';
import 'package:hungry/models/core/recipe.dart';
import 'package:hungry/utils/consts.dart';

class ReviewClient {
  static final ReviewClient _instance = ReviewClient._internal();

  ReviewClient._internal();

  factory ReviewClient() {
    return _instance;
  }

  Future<ApiResponse> addReview(Map<String, dynamic> review) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final req = await http.post(
      Uri.parse("$reviewUrl"),
      headers: headers,
      body: jsonEncode(review),
      encoding: const Utf8Codec(),
    );

    return ApiResponse.fromJson(
        jsonDecode(utf8.decode(req.bodyBytes)) as Map<String, dynamic>);
  }


  Future<ApiResponse> updateReview(
      String id, Map<String, dynamic> recipe) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final req = await http.post(
      Uri.parse("$reviewUrl/$id"),
      headers: headers,
      body: jsonEncode(recipe),
      encoding: const Utf8Codec(),
    );

    return ApiResponse.fromJson(jsonDecode(
      utf8.decode(req.bodyBytes),
    ) as Map<String, dynamic>);
  }

  /*Future<List<Recipe>> getUserRev(String idUser) async {
    final Map<String, String> headers = {'Accept': 'application/json'};

    final req = await http.get(
      Uri.parse("$reviewUrl/$idUser"),
      headers: headers,
    );

    final responseData = json.decode(
      utf8.decode(req.bodyBytes),
    );

    return responseData.map((e) => Recipe.fromJson(e)).toList();
  }*/

  Future<List<Review>> getAllReviews() async {
    final Map<String, String> headers = {'Accept': 'application/json'};

    final req = await http.get(Uri.parse(reviewUrl), headers: headers);

    final responseData = json.decode(
      utf8.decode(req.bodyBytes),
    );

    return responseData.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<ApiResponse> deleteReview(String recipeId) async {
    final Map<String, String> headers = {'Accept': 'application/json'};

    final req = await http.delete(
      Uri.parse("$reviewUrl/$recipeId"),
      headers: headers,
    );

    return ApiResponse.fromJson(
        jsonDecode(utf8.decode(req.bodyBytes)) as Map<String, dynamic>);
  }
}
