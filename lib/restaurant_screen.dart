// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';

class RestaurantScreen extends StatefulWidget {
  RestaurantScreen({
    super.key,
    required this.restaurant,
    required this.img,
    required this.rating,
  });

  final restaurant;
  String img;
  String rating;

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String dropdownValue = "Monday";

  _launchMapsUrl(latitude, longitude) async {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchMapsUrl(widget.restaurant["latlng"]["lat"],
              widget.restaurant["latlng"]["lng"]);
        },
        shape: const StadiumBorder(),
        backgroundColor: Colors.orange,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_outlined,
              color: Colors.white,
            ),
            Text(
              "Go",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.33,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.img), fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.restaurant["name"],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.restaurant["name"],
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
                                widget.rating,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.restaurant["neighborhood"],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                        widget.restaurant["cuisine_type"],
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
                        widget.restaurant["address"],
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
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 220,
                        child: Text(
                          "$dropdownValue: ${widget.restaurant["operating_hours"][dropdownValue]}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        items: const [
                          DropdownMenuItem(
                            value: "Monday",
                            child: Text(
                              "Monday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Tuesday",
                            child: Text(
                              "Tuesday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Wednesday",
                            child: Text(
                              "Wednesday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Thursday",
                            child: Text(
                              "Thursday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Friday",
                            child: Text(
                              "Friday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Saturday",
                            child: Text(
                              "Saturday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Sunday",
                            child: Text(
                              "Sunday",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Raiting & Reviews",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.74,
                  child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.restaurant["reviews"].length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
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
                                        widget.restaurant["reviews"][index]
                                                ["rating"]
                                            .toString(),
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
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.restaurant["reviews"][index]["name"],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ReadMoreText(
                            widget.restaurant["reviews"][index]["comments"],
                            trimLines: 3,
                            trimCollapsedText: "Read more",
                            trimMode: TrimMode.Line,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.restaurant["reviews"][index]["date"]),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
