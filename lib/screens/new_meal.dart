import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:losrios/data/dummy_data.dart';
import 'package:losrios/models/meal.dart';
import 'package:losrios/providers/filters_provider.dart';

import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewMeal extends ConsumerStatefulWidget {
  const NewMeal({super.key, this.meal});

  final Meal? meal;

  @override
  ConsumerState<NewMeal> createState() {
    return _NewMealState();
  }
}

class _NewMealState extends ConsumerState<NewMeal> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  double _enteredPrice = 0.0;
  var _enteredDescription = '';
  double _enteredQuantity = 1;
  var _selectedCategory = availableCategories.first ;
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      if (!context.mounted) {
        return;
      }

      final isNewMeal = widget.meal == null ? true : false;

      Navigator.of(context).pop(Meal(
          id: widget.meal == null ? uuid.v4() : widget.meal!.id,
          category: _selectedCategory.id,
          title: _enteredName,
          imageUrl:
            isNewMeal ? 'https://fudo-apps-storage.s3-sa-east-1.amazonaws.com/production/80551/common/products/44' : widget.meal!.imageUrl,
          price: _enteredPrice,
          description: _enteredDescription,
          state: 'activo',));
      //Navigator.of(context).pop();
    }
  }



  @override
  Widget build(BuildContext context) {
     ref.watch(filteredMealsProvider);
    final isNewMeal = widget.meal == null ? true : false;

    if(!isNewMeal){
      _selectedCategory = availableCategories.firstWhere((category) => category.id == widget.meal!.category);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: isNewMeal ? '' : widget.meal!.title,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Nombre'),
                  ),
                  
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  initialValue: isNewMeal ? '' : widget.meal!.description,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    label: Text('Descripción'),
                  ),
                  
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 200) {
                      return 'Must be between 1 and 200 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredDescription = value!;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Precio'),
                        ),
                        initialValue: isNewMeal ? _enteredQuantity.toString() : widget.meal!.price.toString() ,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null ||
                              double.tryParse(value)! < 0) {
                            return 'Debe ser un valor válido';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPrice = double.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _selectedCategory,
                          items: [
                            for (final category in availableCategories)
                              DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.color,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(category.title),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold),)),
                    ElevatedButton(
                        onPressed: _isSending ? null : _saveItem,
                        child: _isSending
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Confirmar', style: TextStyle(fontWeight: FontWeight.bold),)),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
