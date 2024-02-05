import 'package:flutter/material.dart';
import 'package:losrios/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losrios/providers/meals_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class AdminProdItem extends ConsumerStatefulWidget {
  const AdminProdItem(
      {super.key,
      required this.meal,
      required this.onSelectMeal,
      required this.addMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;
  final void Function(Meal? meal) addMeal;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AdminProdItemState();
  }
}

String stateText(String state) {
  return state[0].toUpperCase() + state.substring(1);
}

// String get affordabilityText {
//   return meal.affordability.name[0].toUpperCase() +
//       meal.affordability.name.substring(1);
// }
class _AdminProdItemState extends ConsumerState<AdminProdItem> {
  @override
  Widget build(BuildContext context) {
    ref.watch(mealsProvider);

    var estado = ref.read(mealsProvider.notifier).isActive(widget.meal) ? 'Activo' : 'Inactivo';

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
          onTap: () {
            widget.onSelectMeal(context, widget.meal);
          },
          splashColor: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Row(
                children: [
                  Card(
                    child: Container(
                        height: 150,
                        width: width / 3,
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(widget.meal.imageUrl),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 2),
                          child: Text(
                              maxLines: 2,
                              widget.meal.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                              maxLines: 1,
                              '\$ ${widget.meal.price.toString()}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        Wrap(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  widget.addMeal(widget.meal);
                                },
                                child: const Text(
                                  'Editar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  ref
                                      .read(mealsProvider.notifier)
                                      .toggleMealState(widget.meal);
                                },
                                child: const Text(
                                  'Activar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),

                  // FadeInImage(
                  //     placeholder: MemoryImage(kTransparentImage),
                  //     image: NetworkImage(meal.imageUrl),
                  //     fit: BoxFit.cover,
                  //     height: 200,
                  //     width: double.infinity,
                  //   ),
                ],
              ),
              Container(
                  height: 30,
                  child: Center(
                    child: Text(
                      'Estado: ${estado}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
          // Stack(
          //   children: [
          //     Hero(
          //       tag: meal.id,
          //       child: FadeInImage(
          //         placeholder: MemoryImage(kTransparentImage),
          //         image: NetworkImage(meal.imageUrl),
          //         fit: BoxFit.cover,
          //         height: 200,
          //         width: double.infinity,
          //       ),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       left: 0,
          //       right: 0,
          //       child: Container(
          //         color: Colors.black54,
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
          //         child: Column(
          //           children: [
          //             Text(
          //               meal.title,
          //               maxLines: 2,
          //               textAlign: TextAlign.center,
          //               softWrap: true,
          //               overflow: TextOverflow.ellipsis, //text ...
          //               style: const TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white),
          //             ),
          //             const SizedBox(height: 12),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 MealItenTrait(
          //                     icon: Icons.schedule,
          //                     label: '${meal.duration} min'),
          //                 const SizedBox(width: 12),
          //                 MealItenTrait(icon: Icons.work, label: complexityText),
          //                 const SizedBox(width: 12),
          //                 MealItenTrait(
          //                     icon: Icons.attach_money, label: affordabilityText),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      );
    });
  }
}
