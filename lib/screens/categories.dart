import 'package:flutter/material.dart';
import 'package:losrios/data/dummy_data.dart';
import 'package:losrios/models/category.dart';
import 'package:losrios/models/meal.dart';
import 'package:losrios/screens/meals.dart';
import 'package:losrios/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.category == category.id,
        )
        .toList();

    //Navigator.of(context).push(route);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        var arrowAmount = (width >= 1000) ? 4 : 2;

        return AnimatedBuilder(
            animation: _animationController,
            child: GridView(
              padding: const EdgeInsets.all(24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: arrowAmount,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                //availableCategories.map((category) => CategoryGridItem(category: category))
                for (final category in availableCategories)
                  CategoryGridItem(
                    category: category,
                    onSelectCategory: () {
                      _selectCategory(context, category);
                    },
                  ),
              ],
            ),
            builder: (context, child) => SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.3),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                        parent: _animationController, curve: Curves.easeInOut),
                  ),
                  child: child,
                ));
      },
    );
  }
}
