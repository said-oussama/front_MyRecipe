class Recipe {
  final String? id;
  final String name;
  final String? photo;
  final int calories;
  final int cookingTime;
  final String description;

  final List<Ingredient> ingredients;
  final List<Review>? reviews;

  Recipe({
    this.id,
    this.photo,
    required this.name,
    required this.calories,
    required this.cookingTime,
    required this.description,
    required this.ingredients,
    this.reviews,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return new Recipe(
      id: json['id'] as String?,
      name: json['name'] as String,
      photo: json['photo'] as String?,
      calories: json['calories'] as int,
      cookingTime: json['cookingTime'] as int,
      description: json['description'] as String,
      ingredients: List<Ingredient>.from(
          json['ingredients'].map((i) => Ingredient.fromJson(i)).toList()),
      reviews: json['reviews'] == null
          ? []
          : List<Review>.from(
              json['reviews'].map((i) => Review.fromJson(i)).toList()),
    );
  }

  @override
  String toString() {
    return '''
    Recipe {
      name: $name,
      photo: $photo,
      calories: $calories,
      cookingTime: $cookingTime,
      description: $description,
      ingredients: ${ingredients.toString()},
      reviews: $reviews,
    }
  ''';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo': photo,
      'calories': calories,
      'cookingTime': cookingTime,
      'description': description,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'reviews': reviews?.map((review) => review.toJson()).toList(),
    };
  }
}

class Review {
  final String username;
  final String review;
  const Review({required this.username, required this.review});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        review: json['review'] as String,
        username: json['username'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'review': review,
    };
  }

  static List<Review> toList(List<Map<String, dynamic>> json) {
    return List.from(json).map((e) => Review.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'review': review,
    };
  }
}

class Ingredient {
  final String name;
  final int quantity;

  const Ingredient({required this.name, required this.quantity});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    final String name = json['name'] as String;
    final dynamic rawQuantity = json['quantity'];

    int parsedQuantity = 0;

    if (rawQuantity != null) {
      if (rawQuantity is int) {
        parsedQuantity = rawQuantity;
      } else if (rawQuantity is String) {
        try {
          parsedQuantity = int.parse(rawQuantity);
        } catch (e) {
          // Handle the case where the quantity is not a valid integer.
          // You might want to log the error or handle it in a way that suits your needs.
          print("Error parsing quantity: $e");
        }
      } else {
        // Handle other types if needed.
        // You might want to log a warning or handle it differently based on your requirements.
        print("Unexpected type for quantity: ${rawQuantity.runtimeType}");
      }
    }

    return Ingredient(name: name, quantity: parsedQuantity);
  }

  static List<Ingredient> toList(List<Map<String, dynamic>> json) {
    return List.from(json).map((e) => Ingredient.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}

