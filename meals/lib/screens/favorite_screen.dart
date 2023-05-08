import 'package:flutter/material.dart';
import '../components/meal_item.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreen({super.key, required this.favoriteMeals});
  
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('Você ainda não possui refeições favoritas :('),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: favoriteMeals[index],
          );
        },
      );
    }
  }
}
