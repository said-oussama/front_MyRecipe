import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hungry/views/utils/AppColor.dart';

class EditRecipeScreen extends StatefulWidget {
  final Map<String, dynamic>? recipeData;

  const EditRecipeScreen({Key? key, this.recipeData}) : super(key: key);

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> _ingredients = [];
  int _ingredientQuantity = 1;
  late TextEditingController _recipeNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _caloriesController;
  late TextEditingController _cookingTimeController;
  late TextEditingController _ingredientNameController; // Add this line

  @override
  void initState() {
    super.initState();
    _recipeNameController = TextEditingController(text: widget.recipeData?['name'] ?? '');
    _descriptionController = TextEditingController(text: widget.recipeData?['description'] ?? '');
    _caloriesController = TextEditingController(text: widget.recipeData?['calories'] ?? '');
    _cookingTimeController = TextEditingController(text: widget.recipeData?['cookingTime'] ?? '');
    _ingredientNameController = TextEditingController(); // Initialize _ingredientNameController
  }

  Future<void> _updateRecipeData() async {
    String apiUrl = 'http://localhost:8080/updatePost/${widget.recipeData?['id']}';

    Map<String, dynamic> updatedRecipeData = {
      'name': _recipeNameController.text,
      'description': _descriptionController.text,
      'calories': _caloriesController.text,
      'cookingTime': _cookingTimeController.text,
      'ingredients': _ingredients,
    };

    http.Response response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedRecipeData),
    );

    if (response.statusCode == 200) {
      print('Recipe updated successfully!');
    } else {
      print('Failed to update recipe. Status code: ${response.statusCode}');
    }
  }

  void _addIngredient() {
    String ingredientName = _ingredientNameController.text;
    if (ingredientName.isNotEmpty) {
      String ingredientString = '$ingredientName ($_ingredientQuantity)';
      setState(() {
        _ingredients.add(ingredientString);
      });
      _ingredientNameController.clear();
      _ingredientQuantity = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Edit recipe',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _recipeNameController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: 'Recipe Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipe name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _caloriesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Calories'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter calories';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _cookingTimeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Cooking Time (minutes)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter cooking time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _ingredientNameController,
                        decoration: InputDecoration(labelText: 'Ingredient Name'),
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      value: _ingredientQuantity,
                      onChanged: (newValue) {
                        setState(() {
                          _ingredientQuantity = newValue!;
                        });
                      },
                      items: List.generate(20, (index) => index + 1).map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        child: Text(
                          'Save Ingredients',
                          style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter'),
                        ),
                        onPressed: _addIngredient,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColor.primarySoft,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _ingredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_ingredients[index]),
                    );
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    child: Text('Save Recipe', style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
                    onPressed: _updateRecipeData,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColor.primarySoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
