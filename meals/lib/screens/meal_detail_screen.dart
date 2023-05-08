import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;
  const MealDetailScreen(
      {super.key, required this.onToggleFavorite, required this.isFavorite});

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 300,
      height: 250,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          meal.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    meal.imageUrl,
                  ),
                ),
              ),
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        meal.ingredients[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'iiFoodRCTextos',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _createSectionTitle(context, 'Passos'),
            _createSectionContainer(ListView.builder(
              itemCount: meal.steps.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        meal.steps[index],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.black45),
                  ],
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isFavorite(meal) ? Icons.star_rounded : Icons.star_outline_rounded),
        onPressed: () {
          onToggleFavorite(meal);
        },
      ),
    );
  }
}
