import 'package:flutter/material.dart';

class GridList extends StatelessWidget {
  const GridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        children: [
          Card(
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/adele.webp',
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:const  [
                    Text(
                      'data',
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
        ],
      ),
    );
  }
}
