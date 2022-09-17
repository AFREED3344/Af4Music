import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/database/model.dart';
import 'package:musicplayer/database/playlistfuntion.dart';
import 'package:musicplayer/playlistsong.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({
    Key? key,
  }) : super(key: key);
  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

final nameController = TextEditingController();

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    flex: 5,
                    child: Text(
                      'Playlist',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //diloge box
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: SizedBox(
                                    height: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                              child: Text(
                                            'Create Your Playlist',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                          TextFormField(
                                              controller: nameController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: ' Playlist Name'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Value is Empty";
                                                } else {
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                              width: 350.0,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.black),
                                                  onPressed: () {
                                                    whenButtonClicked();
                                                    nameController.clear();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Save')))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ValueListenableBuilder(
                // calling database
                valueListenable: Hive.box<MusicModel>('playlist').listenable(),
                builder: (BuildContext context, Box<MusicModel> playlistDb,
                    Widget? child) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: 600,
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0),
                          // shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            final data = playlistDb.values.toList()[index];
                            return InkWell(
                              onTap: (() => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => PlaylistData(
                                          playlist: data,
                                          folderindex: index)))),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 73, 72, 72)),
                                  color: const Color.fromARGB(255, 34, 34, 34),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 30,
                                width: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, left: 3),
                                      child: Text(
                                        // display
                                        data.name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 100),
                                      //bottomsheet
                                      child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) {
                                                  return Container(
                                                    decoration: const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25.0))),
                                                    child: SizedBox(
                                                      height: 300,
                                                      child: Column(
                                                        children: [
                                                          // Image.asset(
                                                          //   'Assets/images/defaultPlaylistImage-removebg-preview.png',
                                                          //   height: 150,
                                                          // ),
                                                          Text(
                                                            data.name,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 30),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 70),
                                                                  child: ElevatedButton.icon(
                                                                      style: ElevatedButton.styleFrom(primary: Colors.transparent),
                                                                      onPressed: () {
                                                                        deletePlaylist(
                                                                            index);
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .delete_outline_outlined,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      label: const Text(
                                                                        'Remove Playlist',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: playlistDb.length),
                    ),
                  );
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  // foloder name adding
  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = MusicModel(name: name, songData: []);
      addPlaylist(music);
    }
  }
}
