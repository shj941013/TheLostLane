// import 'package:thelostlane/Provider/favorite_provider.dart';
import 'package:thelostlane/views/place_detail_screen.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayPlace extends StatefulWidget {
  const DisplayPlace({super.key});

  @override
  State<DisplayPlace> createState() => _DisplayPlaceState();
}

class _DisplayPlaceState extends State<DisplayPlace> {
  // collection for place items
  //TODO:: find the collection near the current person's location.
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection("theLostLanesCollection");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final provider = FavoriteProvider.of(context);
    return StreamBuilder(
      stream: placeCollection.snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: streamSnapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final place = streamSnapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlaceDetailScreen(place: place),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 375,
                              width: double.infinity,
                              child: AnotherCarousel(
                                images: place['imageUrls']
                                    .map((url) => NetworkImage(url))
                                    .toList(),
                                dotSize: 6,
                                indicatorBgPadding: 5,
                                dotBgColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 15,
                            right: 15,
                            child: Row(
                              children: [
                                place['isActive'] == true
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 5,
                                          ),
                                          child: Text(
                                            "Favorites",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                const Spacer(),
                                // for favorite button
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // white border
                                    const Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 34,
                                      color: Colors.white,
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     provider.toggleFavorite(place);
                                    //   },
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            place['address'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star),
                          const SizedBox(width: 5),
                          Text(
                            place['rating'].toString(),
                          ),
                        ],
                      ),
                      Text(
                        "Try ${place['vendor']}.",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16.5,
                        ),
                      ),
                      Text(
                        place['date'],
                        style: const TextStyle(
                          fontSize: 16.5,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: size.height * 0.007),
                      RichText(
                        text: TextSpan(
                          text: "\$${place['price']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          children: const [
                            TextSpan(
                              text: "night",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
