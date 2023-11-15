import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:hungry/models/core/recipe.dart';
import 'package:hungry/utils/consts.dart';
import 'package:hungry/views/screens/recipe_detail_page.dart';
import 'package:hungry/utils/AppColor.dart';

import '../../api/recipe_client.dart';
import '../../models/core/api_response.dart';
import '../screens/edit_recipe.dart';

class RecipeTile extends StatefulWidget {
  final Recipe data;

  final void Function()? onDeleteAction;

  RecipeTile({required this.data, this.onDeleteAction});

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecipeDetailPage(
            data: widget.data,
          ),
        ),
      ),
      child: Container(
        height: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.whiteSoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Recipe Photo
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: widget.data.photo == null
                      ? AssetImage("assets/images/healthy.jpg")
                      : Image.network("$apiUrl/img/${widget.data.photo}").image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Recipe Info
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe title
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        widget.data.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontFamily: 'inter'),
                      ),
                    ),
                    // Recipe Calories and Time
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/fire-filled.svg',
                          color: Colors.black,
                          width: 12,
                          height: 12,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.data.calories}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.alarm,
                          size: 14,
                          color: Colors.black,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.data.cookingTime}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Modifier Button (Replace 'your_modifier_icon' with the actual icon you want to use)
            IconButton(
              icon: Icon(Icons.edit), // Change to your desired modifier icon
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => EditRecipeScreen(data: widget.data),
                ),
              ),
              // Add the logic for the modifier button here
            ),
            // Cross Button
            IconButton(
              icon: Icon(Icons.close),
              onPressed: widget.onDeleteAction,
            ),
          ],
        ),
      ),
    );
  }
}
