import 'package:flutter/material.dart';

import 'package:losrios/models/category.dart';
import 'package:losrios/models/meal.dart';

// Constants in Dart should be written in lowerCamelcase.
const availableCategories = [
  Category(
    id: 'c1',
    title: 'Acomp. dulces',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Acomp. salados',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Café negro',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'Café con leche',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Café frio',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Té',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Tartas',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Tortas',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Otras bebidas',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Tartaletas',
    color: Colors.teal,
  ),
];

const dummyMeals = [
  Meal(
    id: 'm1',
    category: 'c1',
    title: 'ALFAJORES DE MAICENA (3 UNIDADES)',
    imageUrl:
        'https://fudo-apps-storage.s3-sa-east-1.amazonaws.com/production/80551/common/products/44',
    
    description: 'ALFAJORES DE MAICENA (3 UNIDADES)',
    price: 1500.00,
    state: 'activo',
  ),
  Meal(
    id: 'm2',
    category: 'c1',
    title: 'BUDÍN CARROT CAKE',
    imageUrl:
      'https://fudo-apps-storage.s3-sa-east-1.amazonaws.com/production/80551/common/products/50',
    description: 'BUDÍN CARROT CAKE',
    price: 2100.00,
    state: 'activo',
  ),
  Meal(
    id: 'm3',
    category: 'c1',
    title: 'MEDIALUNA DULCE',
    imageUrl:
    'https://fudo-apps-storage.s3-sa-east-1.amazonaws.com/production/80551/common/products/43',
    description: 'MEDIALUNA DULCE',
    price: 650.00,
    state: 'inactivo',
  ),
  Meal(
    id: 'm4',
    category: 'c2',
    title: 'CHIPACITOS',
    imageUrl:
    'https://fudo-apps-storage.s3-sa-east-1.amazonaws.com/production/80551/common/products/34',
    description: 'CHIPACITOS',
    price: 650.00,
    state: 'activo',
  ),
];
