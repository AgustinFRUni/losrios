import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/models/meal.dart';
import 'package:losrios/providers/favorites_provider.dart';
import 'package:losrios/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends ConsumerWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  // String get complexityText {
  //   return meal.complexity.name[0].toUpperCase() +
  //       meal.complexity.name.substring(1);
  // }

  // String get affordabilityText {
  //   return meal.affordability.name[0].toUpperCase() +
  //       meal.affordability.name.substring(1);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoriteMealsProvider);

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        splashColor: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, //text ...
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItenTrait(
                            icon: Icons.attach_money_outlined,
                            label: '${meal.price}'),
                        const SizedBox(width: 12),
                        // const MealItenTrait(icon: Icons.add_shopping_cart, label: 'Añadir'),
                        // const SizedBox(width: 12),
                        const MealItenTrait(
                            icon: Icons.search, label: 'Ver detalles'),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
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
                          child: MealItenTrait(
                            icon: Icons.shopping_cart_checkout_sharp,
                            label: ref
                                    .read(favoriteMealsProvider.notifier)
                                    .isMealFavorite(meal)
                                ? 'Quitar'
                                : 'Añadir',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
