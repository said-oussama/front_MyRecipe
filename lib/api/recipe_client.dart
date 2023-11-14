import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:hungry/models/core/recipe.dart';

import 'package:hungry/models/core/api_response.dart';
import 'package:hungry/utils/consts.dart';

class RecipeClient {

  static final RecipeClient _instance = RecipeClient._internal();

  RecipeClient._internal();

  factory RecipeClient() {
    return _instance;
  }

 

  Future<ApiResponse> addRecipe(Map<String, dynamic> recipe,String token) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final req = await http.post(
      Uri.parse("$apiUrl"),
      headers: headers,
      body: jsonEncode(recipe),
      encoding: const Utf8Codec(),
    );

    return ApiResponse.fromJson(jsonDecode(req.body));
  }

  Future<ApiResponse> setRecipePhoto(String recId, String file) async {
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json'
    };

    final req = http.MultipartRequest(
      'PATCH',
      Uri.parse("$apiUrl/$recId"),
    );

    req.headers.addAll(headers);

    req.files.add(await http.MultipartFile.fromPath("image", file));

    final res = await http.Response.fromStream(await req.send());

    return ApiResponse.fromJson(jsonDecode(
      utf8.decode(res.bodyBytes),
    ) as Map<String, dynamic>);
  }

  Future<ApiResponse> updateRecipe(
      String id, Map<String, dynamic> recipe) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final req = await http.post(
      Uri.parse("$apiUrl/$id"),
      headers: headers,
      body: jsonEncode(recipe),
      encoding: const Utf8Codec(),
    );

    return ApiResponse.fromJson(jsonDecode(req.body) as Map<String, dynamic>);
  }

  Future<List<Recipe>> getUserRecipes(String idUser) async {
    final Map<String, String> headers = {'Accept': 'application/json'};

    final req = await http.get(
      Uri.parse("$apiUrl/$idUser"),
      headers: headers,
    );

    final responseData = jsonDecode(req.body);

    return responseData.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<List<Recipe>> getAllRecipes() async {
    final Map<String, String> headers = {'Accept': 'application/json'};

    final req = await http.get(Uri.parse(apiUrl), headers: headers);

    final responseData = jsonDecode(req.body);

    developer.log(responseData.toString(), name: "get all");

    return List<dynamic>.from(responseData)
        .map((e) => Recipe.fromJson(e))
        .toList();
  }

  Future<ApiResponse> deleteRecipe(String recipeId) async {
    final Map<String, String> headers = {'Accept': 'application/json'};

    final req = await http.delete(
      Uri.parse("$apiUrl/$recipeId"),
      headers: headers,
    );

    return ApiResponse.fromJson(jsonDecode(req.body));
  }
}
