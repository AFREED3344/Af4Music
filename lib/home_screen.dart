import 'package:flutter/material.dart';
import 'package:musicplayer/database/favouritebutton.dart';
import 'package:musicplayer/database/favouritedb.dart';
import 'package:musicplayer/nowplayscreen.dart';
import 'package:musicplayer/settings.dart';
import 'package:musicplayer/widgets/getsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static List<SongModel> songs = [];

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermition();
  }

  void requestPermition() async {
    await Permission.storage.request();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Just For You',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const SettingsScreen())));
              },
              icon: const Icon(
                Icons.settings,
                size: 25,
              )),
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('Sorry No Songs Found'),
            );
          }
          // adding song to screenhome.song
          ScreenHome.songs = item.data!;
          if (!FavoriteDB.isInitialized) {
            FavoriteDB.initialise(item.data!);
          }
          GetSongs.songscopy = ScreenHome.songs;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 2,
            ),
            itemCount: item.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  GetSongs.player.setAudioSource(
                      GetSongs.createSongList(item.data!),
                      initialIndex: index);
                  GetSongs.player.play();
                  setState(() {});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NowPlay(
                          playerSong: item.data!,
                        ), //songmodel Passing
                      ));
                },
                child: Card(
                  color: Colors.transparent,
                  surfaceTintColor: Colors.white,
                  elevation: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        //  flex: 6,
                        child: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note_outlined,
                            color: Colors.white,
                            size: 70,
                          ),
                          artworkFit: BoxFit.fill,
                          artworkBorder: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                // ignore: sized_box_for_whitespace
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.data![index].displayNameWOExt,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${item.data![index].artist}",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: FavoriteBut(song: item.data![index]))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
