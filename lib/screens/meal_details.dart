import 'package:flutter/material.dart';
import 'package:losrios/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MealDetailsScreenState();
  }
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    ref.watch(favoriteMealsProvider);

    var meal = widget.meal;

    final isFavorite = ref
                    .read(favoriteMealsProvider.notifier)
                    .isMealFavorite(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        // actions: [
        //   IconButton(

        //     icon: AnimatedSwitcher(
        //       duration: const Duration(milliseconds: 300),
        //       transitionBuilder: (child, animation) {
        //         return RotationTransition(
        //           turns: Tween<double>(begin: 0.9, end: 1).animate(animation),
        //           child: child,
        //         );
        //       },
        //       child: Icon(
        //         isFavorite ? Icons.star : Icons.star_border,
        //         key: ValueKey(isFavorite),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image(
                image: NetworkImage(meal.imageUrl),
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_money_rounded, size: 35, color: Theme.of(context).colorScheme.primary),
                Text(
              textAlign: TextAlign.center,
              meal.price.toString() ,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900, fontSize: 30),
            ),
              ],
            )
            ,
            const SizedBox(
              height: 14,
            ),
            Text(
              textAlign: TextAlign.center,
              meal.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            // for (final ingredient in meal.ingredients)
            //   Text(
            //     ingredient,
            //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //           color: Theme.of(context).colorScheme.onBackground,
            //         ),
            //   ),
            const SizedBox(
              height: 24,
            ),
            // Text(
            //   'Steps',
            //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //       color: Theme.of(context).colorScheme.primary,
            //       fontWeight: FontWeight.bold),
            // ),
            const SizedBox(
              height: 14,
            ),
            //for (final step in meal.description)
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //child:
            Text(
              meal.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            //),
            const SizedBox(
              height: 14,
            ),

            OutlinedButton.icon(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? 'Añadido al pedido.'
                        : 'Removido del pedido.'),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              key: ValueKey(isFavorite),
              label: Text(
                isFavorite ? 'Remover del pedido' : 'Añadir al pedido',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  
