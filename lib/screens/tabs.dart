import 'package:losrios/providers/meals_provider.dart';
import 'package:losrios/screens/admin_products.dart';
import 'package:losrios/screens/auth.dart';
import 'package:losrios/screens/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/screens/categories.dart';
import 'package:losrios/widgets/main_drawer.dart';
import 'package:losrios/providers/favorites_provider.dart';
import 'package:losrios/providers/filters_provider.dart';


class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    final meals = ref.watch(mealsProvider);

    Navigator.of(context).pop();
    if (identifier == 'signin') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const AuthScreen(),
        ),
      );
    }
     if (identifier == 'products') {
      if(!context.mounted) return;
        await Navigator.of(context).push(
         MaterialPageRoute(
          builder: (ctx) =>  AdminProductsScreen(meals: meals, title: 'Tus productos',),
         ),
       );
     }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Menú';

    if (_selectedPageIndex == 1) {
      ref.watch(favoriteMealsProvider).toList();
      activePage = const OrderScreen(
       // meals: favoriteMeals
        );
      activePageTitle = 'Tu pedido';
    }

    // Widget activePage = _selectedPageIndex == 1
    //     ? MealsScreen(
    //         meals: _favouriteMeals,
    //         onToggleFavourite: _toggleMealFavouriteStatus,
    //       )
    //     : CategoriesScreen(
    //         onToggleFavourite: _toggleMealFavouriteStatus,
    //         availableMeals: availableMeals,
    //       );

    // var activePageTitle =
    //     _selectedPageIndex == 1 ? 'Your Favorites' : 'Categories';

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle, style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),),
        //backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items:  [
          BottomNavigationBarItem(
              icon: const Icon(Icons.list), label: 'Menú', backgroundColor: Theme.of(context).colorScheme.secondary),
          const BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: 'Pedido'),
        ],
      ),
    );
  }
}
