// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Play List',
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (ctx) => createPlayList());
              },
              icon: const Icon(
                Icons.add,
                size: 25,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.more_horiz,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                showMenu(
                    color: Colors.black,
                    context: context,
                    position: const RelativeRect.fromLTRB(6, 4, 1, 10),
                    items: const [
                      PopupMenuItem<int>(
                        value: 0,
                        textStyle: TextStyle(color: Colors.white),
                        child: Text('Select'),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        textStyle: TextStyle(color: Colors.white),
                        child: Text('Select All'),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        textStyle: TextStyle(color: Colors.white),
                        child: Text('Delete'),
                      ),
                    ]);
              },
            ),
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
                            'FolderName',
                            style: TextStyle(color: Colors.white),
                          ),
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

  Widget createPlayList() {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Playlist Name',
        style: TextStyle(color: Colors.white),
      ),
      content: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: 'Name Required',
            hintStyle: TextStyle(color: Colors.white38),
            fillColor: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            child: const Text('Save'))
      ],
    );
  }
}
