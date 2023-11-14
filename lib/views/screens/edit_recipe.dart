import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:hungry/api/recipe_client.dart';
import 'package:hungry/config/init_config.dart';
import 'package:hungry/utils/AppColor.dart';

import '../../models/core/recipe.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({Key? key}) : super(key: key);

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  List<String> _ingredients = [];
  int _ingredientQuantity = 1;

  late TextEditingController _ingredientNameController;
  late TextEditingController _recipeNameController;
  late TextEditingController _caloriesCountController;
  late TextEditingController _cookingTimeController;
  late TextEditingController _descriptionController;

  String _name = '';
  String _desc = '';
  int _calories = 0;
  int _cookingTime = 0;

  String? _selectedImgPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ingredientNameController = TextEditingController();
    _recipeNameController = TextEditingController();
    _caloriesCountController = TextEditingController();
    _cookingTimeController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _ingredientNameController.dispose();
    _recipeNameController.dispose();
    _caloriesCountController.dispose();
    _cookingTimeController.dispose();
    _descriptionController.dispose();
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

  // Future<void> _sendRecipeData() async {
  //   // Prepare your recipe data here
  //   List<Map<String, dynamic>> formattedIngredients =
  //   _ingredients.map((ingredient) {
  //     // Split the ingredient string to extract name and quantity
  //     List<String> parts = ingredient.split(' ');
  //     String name = parts[0];
  //     String quantity = parts[1].replaceAll('(', '').replaceAll(')', '');

  //     // Format the ingredient according to your backend schema
  //     return {
  //       'name': name,
  //       'quantity': quantity,
  //     };
  //   }).toList();

  //   final finalIngredients =
  //   formattedIngredients.map((e) => Ingredient.fromJson(e)).toList();

  //   // Send the recipe data to the server

  //   final Map<String, dynamic> rec = {
  //     "name": _name,
  //     "description": _desc,
  //     "ingredients": finalIngredients,
  //     "cookingTime": _cookingTime,
  //     "calories": _calories,
  //   };

  //   developer.log(rec.toString(), name: "add recipe var");

  //   final response = await RecipeClient().addRecipe(rec);

  //   if (response.error != null) {
  //     developer.log(response.error!, name: "ADD RECIPE");
  //   } else {
  //     final String recId = response.id!;

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(response.message!),
  //       ),
  //     );
  //     await _uploadImage(recId);
  //   }
  // }

  Future<void> _uploadImage(String id) async {
    if (_selectedImgPath == null) return;

    final response = await RecipeClient().setRecipePhoto(id, _selectedImgPath!);

    if (response.error != null) {
      developer.log(response.error!, name: "UPLOAD IMAGE");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message!),
        ),
      );
    }
  }

  Future<void> _selectImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    String pathToFolder =
    await InitConfiguration.createImagesFolderInAppDocDir();
    String imageName = DateTime.now().toString().substring(0, 19);
    pickedFile.saveTo('$pathToFolder$imageName.jpeg');

    setState(() {
      _selectedImgPath = "$pathToFolder$imageName";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: false,
        automaticallyImplyLeading: true,
        elevation: 5,
        title: Text(
          'Add recipe',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async => await _selectImage(),
                      child: SizedBox(
                        height: 150,
                        child: _selectedImgPath != null
                            ? Image.file(
                          File(_selectedImgPath!),
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "images/placeholder.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _recipeNameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'RecipeName',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: AppColor.primary,
                          width: 2.0), // Customize the border color and width
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.indigo,
                          width:
                          2.0), // Customize the border color and width when the TextField is focused
                    ),
                    hintText: 'Kouskous',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    // You can add additional validation logic for description here.
                    return null;
                  },
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: AppColor.primary,
                          width: 2.0), // Customize the border color and width
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.indigo,
                          width:
                          2.0), // Customize the border color and width when the TextField is focused
                    ),
                    hintText: 'Le KousKous est un plat tunisien',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    // You can add additional validation logic for description here.
                    return null;
                  },
                  onChanged: (value) {
                    _desc = value;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _caloriesCountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Calories',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: AppColor.primary,
                                width:
                                2.0), // Customize the border color and width
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                width:
                                2.0), // Customize the border color and width when the TextField is focused
                          ),
                          hintText: '1000...2500',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter calories';
                          }
                          // You can add additional validation logic for calories here.
                          return null;
                        },
                        onChanged: (value) {
                          _calories = int.parse(value);
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _cookingTimeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Cooking Time (minutes)',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: AppColor.primary,
                                width:
                                2.0), // Customize the border color and width
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                width:
                                2.0), // Customize the border color and width when the TextField is focused
                          ),
                          hintText: 'In Minutes',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter cooking time';
                          }
                          // You can add additional validation logic for cooking time here.
                          return null;
                        },
                        onChanged: (value) {
                          _cookingTime = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ingredientNameController,
                        decoration: InputDecoration(
                          labelText: 'Ingredient Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: AppColor.primary,
                                width:
                                2.0), // Customize the border color and width
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                width:
                                2.0), // Customize the border color and width when the TextField is focused
                          ),
                          hintText: 'Bsal',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      hint: const Text("1"),
                      value: _ingredientQuantity,
                      onChanged: (int? newValue) {
                        setState(() {
                          _ingredientQuantity = newValue!;
                        });
                      },
                      items: List.generate(20, (index) => index + 1)
                          .map<DropdownMenuItem<int>>(
                            (int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text("$value"),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        child: Text(
                          'Save Ingredients',
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'inter'),
                        ),
                        onPressed: _addIngredient,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
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
                    child: Text(
                      'Save Recipe',
                      style: TextStyle(
                          color: AppColor.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter'),
                    ),
                    onPressed:(){},
                    // () async => await _sendRecipeData(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
