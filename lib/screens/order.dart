import 'package:flutter/material.dart';

import 'package:losrios/models/meal.dart';
import 'package:losrios/screens/meal_details.dart';
import 'package:losrios/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key, this.title});

  final String? title;
  //final List<Map<Meal, int>> meals;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends ConsumerState<OrderScreen>{

//   openwhatsapp(String number, String order) async{
//   var whatsapp = number;
//   Uri whatsappURl_android = Uri.parse("whatsapp://send?phone=${whatsapp}&text=${order}")  ;
  
//     // android , web
//     if( await canLaunchUrl(whatsappURl_android)){
//       await launchUrl(whatsappURl_android);
//     }else{
//        ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Whatsapp no instalado")));
//     }
  
// }

void sendWhatsapp(String number, String order) async{
   String whatsappUrl="whatsapp://send?phone=$number&text=$order";
  //String whatsappUrl = "https://api.whatsapp.com/send?phone=543794122285";
  //String whatsappUrl = "https://wa.me/$number";
  

  // print(Uri.parse(whatsappUrl));
  // print(await canLaunchUrl(Uri.parse(whatsappUrl)));

  // if( await canLaunchUrl(Uri.parse(whatsappUrl))){
      await launchUrl(Uri.parse(whatsappUrl));
    // }else{
    //    ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Whatsapp no instalado")));
    // }

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
    final meals = ref.watch(favoriteMealsProvider);

    Widget content = Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => ListTile(
              isThreeLine: true,
              subtitle: Text('\$ ${meals[index].entries.first.key.price}'),
              key: ValueKey(meals[index]),
              leading: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  final wasAdded = ref
                      .read(favoriteMealsProvider.notifier)
                      .toggleMealFavoriteStatus(meals[index].entries.first.key);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          wasAdded ? 'Añadido al pedido.' : 'Removido del pedido.'),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.cancel_sharp,
                  color: Colors.red,
                ),
              ),
              title: Text(meals[index].entries.first.key.title,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () {
                selectMeal(context, meals[index].entries.first.key);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {
                    ref
                      .read(favoriteMealsProvider.notifier)
                      .removeMeal(meals[index].entries.first.key);
                  }, icon: const Icon(Icons.remove)),
                  Text(
                    meals[index].entries.first.value.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(onPressed: () {
                    ref
                      .read(favoriteMealsProvider.notifier)
                      .addMeal(meals[index].entries.first.key);
                  }, icon: const Icon(Icons.add)),
                ],
              ),
            ),
          
            //  MealItem(
            //   meal: meals[index],
            //   onSelectMeal: (context, meal) {
            //     selectMeal(context, meal);
            //   },
            // ),
          ),
        ),
        ListTile(
          leading: const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          title:
          //  Row(children: [
            Text('\$ ${ref
                      .read(favoriteMealsProvider.notifier)
                      .totalPrice()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          trailing:            TextButton(onPressed: () => showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('¿Todo listo?'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Quieres confirmar tu pedido?'),
              //Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Confirmar'),
            onPressed: () {
              String number = 
              ref.read(favoriteMealsProvider.notifier).getNumber();
              String order = ref.read(favoriteMealsProvider.notifier).getOrder();
              sendWhatsapp(number, order);
            },
          ),
        ],
      );
    },
  ), child: const Text('Terminar')),
          // ],) 
        ),
      ],
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textAlign: TextAlign.center,
                'Aún no has añadido nada a tu pedido.',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Visita nuestros productos!',
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
      ),
      body: content,
    );
  }
}


  



   
