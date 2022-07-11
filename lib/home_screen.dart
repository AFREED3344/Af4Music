import 'package:flutter/material.dart';
import 'package:musicplayer/settings.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const SettingsScreen())));
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 30,
                  ))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 100),
              child: Text(
                'Recently Played ...',
                style: TextStyle(
                    color: Color.fromARGB(255, 192, 190, 190),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: GridView.builder(
                //scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // return
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: const Color.fromARGB(255, 253, 253, 254))),
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/songs icon.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Row(
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
                          ))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 180),
              child: Text(
                'Just For You',
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 195, 195),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                flex: 4,
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
                          border: Border.all(
                              color: const Color.fromARGB(255, 253, 253, 254))),
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
                  itemCount: 6,
                )),
          ],
        ),
      ),
    );
  }
}
