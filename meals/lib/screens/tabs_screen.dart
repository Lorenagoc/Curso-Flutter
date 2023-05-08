import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import '../components/main_drawer.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen({super.key, required this.favoriteMeals});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Lista de Categorias', 'screen': const CategoriesScreen()},
      {
        'title': 'Meus Favoritos',
        'screen': FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        )
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _screens[_selectedScreenIndex]['title'].toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          currentIndex: _selectedScreenIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              icon: const Icon(Icons.apps_rounded),
              label: 'Categorias',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              icon: const Icon(Icons.star_rounded),
              label: 'Favoritos',
            ),
          ]),
    );
  }
}
