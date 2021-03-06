import 'package:flutter/material.dart';
import 'package:friendly_eats/restaurant_page.dart';
import 'home_page.dart';

class FriendlyEatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyEats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RestaurantPage.route:
            final RestaurantPageArguments arguments = settings.arguments;
            return MaterialPageRoute(
                builder: (context) => RestaurantPage(
                  restaurantId: arguments.id,
                ));
            break;
          default:
          // return MaterialPageRoute(
          //     builder: (context) => RestaurantPage(
          //           restaurantId: 'lV81npEeboEActMpUJjn',
          //         ));
          // Everything defaults to home, but maybe we want a custom 404 here
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
    );
  }
}
