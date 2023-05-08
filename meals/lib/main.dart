import 'package:meals/models/settings.dart';
import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'utils/app_routes.dart';
import 'screens/tabs_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_meals_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoriteMeals = [];
  Settings settings = Settings();

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        fontFamily: 'iFoodRCTextos',
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 255, 17, 0)),
        // canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(
          secondary: Colors.black,
          brightness: Brightness.dark,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
                titleLarge: const TextStyle(
              fontSize: 20,
              fontFamily: 'iFoodRCTextos',
            )),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(
              meals: _availableMeals,
            ),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(
              onToggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(
              onSettingsChanged: _filterMeals,
              settings: settings,
            ),
      },
    );
  }
}
