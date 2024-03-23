// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_1/login_screen.dart';
import 'package:restaurant_1/restaurant_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future restaurant;
  Future getRestaurantData() async {
    try {
      final result = await http.get(
        Uri.parse(
          'https://run.mocky.io/v3/9c7d5c0d-5dd9-4b72-b158-fcf4f61a956b',
        ),
      );

      final data = jsonDecode(result.body);

      if (result.statusCode != 200) {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    restaurant = getRestaurantData();
  }

  List<String> images = [
    "https://media.istockphoto.com/id/183885690/photo/hotel-veranda.jpg?s=612x612&w=0&k=20&c=DS_AGUSnRMc3_0znJscJWf-NTORCnyEhlfmlvS0wEv4=",
    "https://media.istockphoto.com/id/1159992039/photo/cozy-restaurant-for-gathering-with-friends.jpg?s=612x612&w=0&k=20&c=FTnWMb2J9lI7M6Q06xlCDBwDq291PbNeU_YwcnzH9f0=",
    "https://media.istockphoto.com/id/1367577101/photo/3d-render-of-cafe-restaurant-bar-interior.jpg?s=612x612&w=0&k=20&c=MZ0XT8kj_XEocoSzgpccuGXk-Lh6yJ2VsRAadTPBW-o=",
    "https://media.istockphoto.com/id/1367577101/photo/3d-render-of-cafe-restaurant-bar-interior.jpg?s=612x612&w=0&k=20&c=MZ0XT8kj_XEocoSzgpccuGXk-Lh6yJ2VsRAadTPBW-o=",
    "https://media.istockphoto.com/id/1160874507/photo/3d-render-of-restaurant-interior.jpg?s=612x612&w=0&k=20&c=zMJ8Kvix02izEUU1QyZQ0OyLPxksxv3zUW2enmRNVNk=",
    "https://media.istockphoto.com/id/183828804/photo/hotel-restaurant-phuket.jpg?s=612x612&w=0&k=20&c=xvdyK44KED58zfe3uT1JK8rSr3PU-Um82PzAJ6m5P6g=",
    "https://media.istockphoto.com/id/1306386597/photo/3d-render-of-airport-vip-lounge.jpg?s=612x612&w=0&k=20&c=7Z-0rFMJWEUamDNznRQzECdDNNDHobg0iR6UPJukxJ0=",
    "https://media.istockphoto.com/id/1255342885/photo/restaurant-interior.jpg?s=612x612&w=0&k=20&c=dn30McOOzo-rCigA7pyAYuBAbHjLoblhs9N-oBHD6Wk=",
    "https://media.istockphoto.com/id/1395505352/photo/interior-of-a-contemporary-coffee-shop-in-3d.jpg?s=612x612&w=0&k=20&c=LRI9evqDRhqrPg5TOdOVYnaAz0fmBj9iVz5gVqCK9OM=",
    "https://media.istockphoto.com/id/901912706/photo/empty-british-pub.jpg?s=612x612&w=0&k=20&c=WNCv-S4FAUqjclVpAFqQh9u0IzAh-KW1z30aUO97icY=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: const Text(
          "RESTAURANTS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ),
                  (route) => false);
            },
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: FutureBuilder(
        future: restaurant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data!;
          final restaurantData = data["restaurants"];
          return ListView.builder(
            itemCount: restaurantData.length,
            itemBuilder: (context, index) {
              return ListItem(
                restaurant: restaurantData[index],
                img: images[index],
              );
            },
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    super.key,
    required this.restaurant,
    required this.img,
  });
  // ignore: prefer_typing_uninitialized_variables
  final restaurant;
  String img;

  @override
  Widget build(BuildContext context) {
    num sum = 0;
    for (int i = 0; i < restaurant["reviews"].length; i++) {
      sum = sum + restaurant["reviews"][i]["rating"];
    }

    double rating = sum / restaurant["reviews"].length;
    rating = (rating * 10).round() / 10.0;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RestaurantScreen(
                  restaurant: restaurant, img: img, rating: rating.toString()),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.43,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            )
          ]),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      restaurant["name"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 25,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green[600],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          restaurant["cuisine_type"],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          restaurant["address"],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
