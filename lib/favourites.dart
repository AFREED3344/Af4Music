import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.only(right: 200, top: 20),
            child: Text(
              'Favourites',
              style: TextStyle(fontSize: 20.5),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 30, top: 25),
              child: Icon(
                Icons.favorite,
                size: 25,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: const Color.fromARGB(255, 253, 253, 254))),
                child: Card(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/songs icon.jpeg',
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'songsname',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: 8,
          ),
        ));
  }
}
