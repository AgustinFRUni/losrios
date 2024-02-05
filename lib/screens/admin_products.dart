import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/providers/meals_provider.dart';
import 'package:losrios/screens/new_meal.dart';
import 'package:losrios/widgets/admin_prod_item.dart';
import 'package:flutter/material.dart';

import 'package:losrios/models/meal.dart';
import 'package:losrios/screens/meal_details.dart';

class AdminProductsScreen extends ConsumerStatefulWidget {
  const AdminProductsScreen({super.key, this.title, this.meals});

  final String? title;
  final List<Meal>? meals;

  @override
  ConsumerState<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends ConsumerState<AdminProductsScreen> {

  void _addItem(Meal? meal) async {
    final newItem = await Navigator.of(context).push<Meal>(
      MaterialPageRoute(
        builder: (ctx) => NewMeal(meal: meal,),
      ),
    );

    if (newItem == null) {
      return;
    }

    ref.read(mealsProvider.notifier).addMeal(newItem);

    // setState(() {
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(
    //                 content: Text('Comida añadida'),
    //               ),
    //             );
    //   print(newItem.entries.first.key.price.toString());
    // });
  }

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
    //Navigator.push(
    //  context,
    //  MaterialPageRoute(
    //    builder: (ctx) => MealDetailsScreen(
    //      meal: meal,
    //    ),
    // ),
    //);
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => AdminProdItem(
        meal: meals[index],
        onSelectMeal: (context, meal) {
          selectMeal(context, meal);
        },
        addMeal: _addItem,
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nada aquí!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Prueba eligiendo otra categoria!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          IconButton(onPressed: (){
            _addItem(null);
            }, icon: const Icon(Icons.add_circle_outline,))
        ],
      ),
      backgroundColor: Colors.white,
      body: content,
    );
  }
}
