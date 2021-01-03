import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/data.dart' as data;
import 'model/filter.dart';
import 'model/restaurant.dart';

class HomePage extends StatefulWidget {
  static const route = '/';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<QuerySnapshot> _currentSubscription;
  bool _isLoading = true;
  List<Restaurant> _restaurants = <Restaurant>[];
  Filter _filter;

  void _updateRestaurants(QuerySnapshot snapshot) {
    setState(() {
      _isLoading = false;
      _restaurants = data.getRestaurantsFromQuery(snapshot);
    });
  }

  _HomePageState() {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
          _currentSubscription = data.loadAllRestaurants().listen(_updateRestaurants);
        print('auth');
        });
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  Future<void> _onFilterBarPressed() async {
    final filter = await showDialog<Filter>(
      context: context,
      builder: (_) => FilterSelectDialog(filter: _filter),
    );
    if (filter != null) {
      await _currentSubscription?.cancel();
      setState(() {
        _isLoading = true;
        _filter = filter;
        if (filter.isDefault) {
          _currentSubscription =
              data.loadAllRestaurants().listen(_updateRestaurants);
        } else {
          _currentSubscription =
              data.loadFilteredRestaurants(filter).listen(_updateRestaurants);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.restaurant),
        title: Text('FriendlyEats'),
        bottom: PreferredSize(
          preferredSize: Size(320, 48),
          child: Padding(
            padding: EdgeInsets.fromLTRB(6, 0, 6, 4),

            // child: FilterBar(
            //   filter: _filter,
            //   onPressed: _onFilterBarPressed,
            // ),

            child: Text('test'),
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1280),

          // child: _isLoading
          //     ? CircularProgressIndicator()
          //     : _restaurants.isNotEmpty
          //     ? RestaurantGrid(
          //     restaurants: _restaurants,
          //     onRestaurantPressed: (id) {
          //       // TODO: Add deep links on web
          //       Navigator.pushNamed(context, RestaurantPage.route,
          //           arguments: RestaurantPageArguments(id: id));
          //     })
          //     : EmptyListView(
          //   child: Text('FriendlyEats has no restaurants yet!'),
          //   onPressed: _onAddRandomRestaurantsPressed,
          // ),

          child: Text('test2'),
        ),
      ),
    );
  }
}
