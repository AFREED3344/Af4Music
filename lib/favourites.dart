import 'package:flutter/material.dart';
import 'package:musicplayer/nowplayscreen.dart';
import 'package:musicplayer/widgets/getsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'database/favouritebutton.dart';
import 'database/favouritedb.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Liked Songs...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FavoriteDB.favoriteSongs.value.isEmpty
                      ? const Center(
                          child: Text(
                            'No Song Found',
                            style: TextStyle(
                                color: Color.fromARGB(255, 163, 161, 161),
                                fontSize: 12),
                          ),
                        )
                      : ValueListenableBuilder(
                          valueListenable: FavoriteDB.favoriteSongs,
                          builder: (BuildContext ctx, List<SongModel> favorData,
                              Widget? child) {
                            return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (ctx, index) {
                                  return ListTile(
                                      onTap: () {
                                        List<SongModel> newlist = [
                                          ...favorData
                                        ];
                                        setState(() {});
                                        GetSongs.player.stop();
                                        GetSongs.player.setAudioSource(
                                            GetSongs.createSongList(newlist),
                                            initialIndex: index);
                                        GetSongs.player.play();
                                        // Storage.currentindex = index;
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) => NowPlay(
                                                      playerSong: newlist,
                                                    )));
                                      },
                                      leading: QueryArtworkWidget(
                                        id: favorData[index].id,
                                        type: ArtworkType.AUDIO,
                                        errorBuilder: (context, excepion, gdb) {
                                          return Image.asset('');
                                        },
                                      ),
                                      title: Text(
                                        favorData[index].title,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      subtitle: Text(
                                        favorData[index].artist!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      trailing:
                                          FavoriteBut(song: favorData[index]));
                                },
                                separatorBuilder: (ctx, index) {
                                  return const Divider();
                                },
                                itemCount: favorData.length);
                          },
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
