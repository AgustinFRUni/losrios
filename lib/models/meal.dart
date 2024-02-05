
class Meal {
  const Meal({
    required this.id,
    required this.category,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.state,
  });

  final String id;
  final String category;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final String state;
}
