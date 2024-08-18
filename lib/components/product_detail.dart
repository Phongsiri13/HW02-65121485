import 'package:flutter/material.dart';
import 'package:flutter_m5_w9/models/product.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Details();
  }
}

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailState();
}

class _DetailState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    var imgUrl = product.image;
    String defaultImgUrl = "https://lh3.googleusercontent.com/proxy/vfrcI3Ho8V8lLS1FWlXFKUAc9p85CQm9WxsUFwOm1zrLrYsStycX5NSOBJS4TYEEX5_3mQkd8QuqnIk";

    // Method to create star icons
    Widget buildRatingStars(double rating) {
      final int fullStars = rating.floor();
      final bool hasHalfStar = rating - fullStars >= 0.5;
      final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

      List<Widget> stars = [];

      // Add full stars
      for (int i = 0; i < fullStars; i++) {
        stars.add(Icon(Icons.star, color: Colors.yellow[600], size: 30.0));
      }

      // Add half star if needed
      if (hasHalfStar) {
        stars.add(Icon(Icons.star_half, color: Colors.yellow[600], size: 30.0));
      }

      // Add empty stars
      for (int i = 0; i < emptyStars; i++) {
        stars.add(
            Icon(Icons.star_border, color: Colors.yellow[600], size: 30.0));
      }

      // Arrange stars in a row
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: stars,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: ListView(
        children: [
          AspectRatio(aspectRatio: 16.0 / 9.0,
          child: Image.network(imgUrl,
          errorBuilder: (context, error, stackTrace) {
          // Display default image if there's an error loading imgUrl
          return Image.network(
            defaultImgUrl
          );
        },)),
          ListTile(
            title: Text(
              "${product.title}",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "\$ ${product.price}",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            title: Text(
              "Category",
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: Text(
              "${product.category}",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          ListTile(
            subtitle: Text(
              "${product.description}",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          ListTile(
            subtitle: Text(
              "Rating: ${product.rating.rate}/5 of ${product.rating.count}",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          // Stars
          ListTile(subtitle: buildRatingStars(product.rating.rate)),
        ],
      ),
    );
  }
}