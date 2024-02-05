import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                  child: 
                    Center(child: Image.asset('assets/images/logo.png')),
                  
                ),
                ListTile(
                  leading: Icon(
                    Icons.restaurant,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    'Comidas',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                  ),
                  onTap: () {
                    onSelectScreen('meals');
                  },
                ),
                // ListTile(
                //   leading: Icon(
                //     Icons.settings,
                //     size: 26,
                //     color: Theme.of(context).colorScheme.onBackground,
                //   ),
                //   title: Text(
                //     'Filtros',
                //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
                //           color: Theme.of(context).colorScheme.onBackground,
                //           fontSize: 24,
                //         ),
                //   ),
                //   onTap: () {
                //     onSelectScreen('filters');
                //   },
                // ),
              ],
            ),
          ),
          ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 26,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text(
                      'Iniciar Sesión',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 24,
                          ),
                    ),
                    onTap: () {
                      onSelectScreen('signin');
                    },
                ),
                ListTile(
                    leading: Icon(
                      Icons.shopping_basket_outlined,
                      size: 26,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text(
                      'Productos',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 24,
                          ),
                    ),
                    onTap: () {
                      onSelectScreen('products');
                    },
                ),
        ],
      ),
    );
  }
}
